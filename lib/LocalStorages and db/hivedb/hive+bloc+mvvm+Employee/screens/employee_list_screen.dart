// lib/screens/employee_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../blocs/employee_bloc.dart';
import '../blocs/employee_event.dart';
import '../blocs/employee_state.dart';
import '../models/employee.dart';
import '../repositories/employee_repository.dart';
import '../viewmodels/employee_viewmodel.dart';
import 'add_edit_employee_screen.dart';
import 'employee_detail_screen.dart';

/// Employee List Screen - View layer in MVC
/// Main screen displaying all employees
class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  final _searchController = TextEditingController();
  String _selectedDepartment = 'All';
  List<String> _departments = ['All'];

  @override
  void initState() {
    super.initState();
    // Fetch employees when screen loads
    Future.microtask(() {
      context.read<EmployeeBloc>()
          .add(const FetchEmployeesEvent());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  /// Handle search functionality
  void _handleSearch(String query) {
    if (query.isEmpty) {
      context.read<EmployeeBloc>()
          .add(const ClearSearchEvent());
    } else {
      context.read<EmployeeBloc>()
          .add(SearchEmployeesEvent(query));
    }
  }

  /// Handle delete with confirmation dialog
  void _handleDelete(Employee employee) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Employee'),
        content: Text('Are you sure you want to delete'
            ' ${employee.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<EmployeeBloc>()
                  .add(DeleteEmployeeEvent(employee.id));
              Navigator.pop(context);
            },
            child: const Text('Delete',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
  /// Handle department filter
  void _handleDepartmentFilter(String department) {
    setState(() {
      _selectedDepartment = department;
    });
    if (department == 'All') {
      context.read<EmployeeBloc>().add(const FetchEmployeesEvent());
    } else {
      context.read<EmployeeBloc>()
          .add(FetchEmployeesByDepartmentEvent(department));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees'),
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: BlocListener<EmployeeBloc, EmployeeState>(
        listener: (context, state) {
          // Listen for errors
          if (state is EmployeeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
          // Listen for successful delete
          if (state is EmployeeDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Employee deleted successfully')),
            );
          }
        },
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                onChanged: _handleSearch,
                decoration: InputDecoration(
                  hintText: 'Search by name...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            _handleSearch('');
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            // Employee list
            Expanded(
              child: BlocBuilder<EmployeeBloc, EmployeeState>(
                builder: (context, state) {
                  if (state is EmployeeLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is NoEmployeesFound) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.people_outline,
                              size: 64, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text('No employees found',
                              style:
                                  Theme.of(context).textTheme.headlineSmall),
                        ],
                      ),
                    );
                  } else if (state is EmployeeLoaded ||
                      state is EmployeeSearchResults ||
                      state is EmployeeSorted) {
                    // Extract employees from different state types
                    List<Employee> employees = [];
                    if (state is EmployeeLoaded) {
                      employees = state.employees;
                    } else if (state is EmployeeSearchResults) {
                      employees = state.results;
                    } else if (state is EmployeeSorted) {
                      employees = state.employees;
                    }

                    return ListView.builder(
                      itemCount: employees.length,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemBuilder: (context, index) {
                        final employee = employees[index];
                        return EmployeeCard(
                          employee: employee,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EmployeeDetailScreen(employee: employee),
                              ),
                            );
                          },
                          onEdit: () {
                            // ✅ CORRECT: Navigation without Provider wrapping
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddEditEmployeeScreen(employee: employee),
                              ),
                            );
                          },
                          onDelete: () => _handleDelete(employee),
                        );
                      },
                    );
                  } else if (state is EmployeeError) {
                    return Center(child: Text(state.message));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          // ✅ CORRECT: Simple navigation, no Provider wrapping needed
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditEmployeeScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Custom card widget for displaying employee information
class EmployeeCard extends StatelessWidget {
  final Employee employee;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const EmployeeCard({
    Key? key,
    required this.employee,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Text(
            employee.name.substring(0, 1).toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(employee.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(employee.position,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(employee.department,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              onTap: onEdit,
              child: const Text('Edit'),
            ),
            PopupMenuItem(
              onTap: onDelete,
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}

// lib/screens/add_edit_employee_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../blocs/employee_bloc.dart';
import '../blocs/employee_event.dart';
import '../blocs/employee_state.dart';
import '../models/employee.dart';
import '../repositories/employee_repository.dart';
import '../viewmodels/employee_viewmodel.dart';

/// Add/Edit Employee Screen - View layer in MVC
/// Form for adding or updating employee information
class AddEditEmployeeScreen extends StatefulWidget {
  final Employee? employee;

  const AddEditEmployeeScreen({Key? key, this.employee}) : super(key: key);

  @override
  State<AddEditEmployeeScreen> createState() => _AddEditEmployeeScreenState();
}

class _AddEditEmployeeScreenState extends State<AddEditEmployeeScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _positionController;
  late TextEditingController _departmentController;
  late TextEditingController _salaryController;
  late DateTime _selectedDate;

  final _formKey = GlobalKey<FormState>();

  // ✅ CORRECT: Create ViewModel directly, no Provider dependency
  late EmployeeViewModel _viewModel;
  Map<String, String> _validationErrors = {};

  // Predefined departments for dropdown
  final List<String> _departments = [
    'IT',
    'HR',
    'Finance',
    'Marketing',
    'Sales',
    'Operations',
    'Customer Support',
  ];

  @override
  void initState() {
    super.initState();

    // ✅ CORRECT: Create ViewModel directly using Repository
    final repository = RepositoryProvider.of<EmployeeRepository>(context);
    _viewModel = EmployeeViewModel(repository: repository);

    // Initialize controllers based on whether it's edit or add mode
    if (widget.employee != null) {
      _nameController = TextEditingController(text: widget.employee!.name);
      _emailController = TextEditingController(text: widget.employee!.email);
      _phoneController = TextEditingController(
        text: widget.employee!.phoneNumber,
      );
      _positionController = TextEditingController(
        text: widget.employee!.position,
      );
      _departmentController = TextEditingController(
        text: widget.employee!.department,
      );
      _salaryController = TextEditingController(
        text: widget.employee!.salary.toString(),
      );
      _selectedDate = widget.employee!.joiningDate;
    } else {
      _nameController = TextEditingController();
      _emailController = TextEditingController();
      _phoneController = TextEditingController();
      _positionController = TextEditingController();
      _departmentController = TextEditingController();
      _salaryController = TextEditingController();
      _selectedDate = DateTime.now();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _positionController.dispose();
    _departmentController.dispose();
    _salaryController.dispose();
    super.dispose();
  }

  /// Validate and submit form
  void _submitForm() {
    // Clear previous errors
    setState(() {
      _validationErrors = {};
    });

    // ✅ CORRECT: Use ViewModel directly
    _validationErrors = _viewModel.validateEmployee(
      name: _nameController.text,
      email: _emailController.text,
      phoneNumber: _phoneController.text,
      position: _positionController.text,
      department: _departmentController.text,
      salary: _salaryController.text,
    );

    if (_validationErrors.isEmpty) {
      // Create or update employee
      final employee = Employee(
        id: widget.employee?.id ?? const Uuid().v4(),
        name: _nameController.text,
        email: _emailController.text,
        phoneNumber: _phoneController.text,
        position: _positionController.text,
        department: _departmentController.text,
        salary: double.parse(_salaryController.text),
        joiningDate: _selectedDate,
        isActive: true,
      );

      if (widget.employee != null) {
        // Edit mode
        context.read<EmployeeBloc>()
            .add(UpdateEmployeeEvent(employee));
      } else {
        // Add mode
        context.read<EmployeeBloc>()
            .add(AddEmployeeEvent(employee));
      }
    } else {
      // Show validation errors
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please correct the errors')),
      );
    }
  }
  /// Pick date from date picker
  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.employee != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? 'Edit Employee' : 'Add Employee'),
        backgroundColor: Colors.blueAccent,
      ),
      body: BlocListener<EmployeeBloc, EmployeeState>(
        listener: (context, state) {
          if (state is EmployeeCreated || state is EmployeeUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isEditMode
                      ? 'Employee updated successfully'
                      : 'Employee added successfully',
                ),
              ),
            );
            Navigator.pop(context);
          } else if (state is EmployeeError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<EmployeeBloc, EmployeeState>(
          builder: (context, state) {
            if (state is EmployeeLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name field
                    _buildTextField(
                      controller: _nameController,
                      label: 'Full Name',
                      hint: 'Enter employee name',
                      errorText: _validationErrors['name'],
                      icon: Icons.person,
                    ),
                    const SizedBox(height: 16),

                    // Email field
                    _buildTextField(
                      controller: _emailController,
                      label: 'Email',
                      hint: 'Enter email address',
                      errorText: _validationErrors['email'],
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),

                    // Phone number field
                    _buildTextField(
                      controller: _phoneController,
                      label: 'Phone Number',
                      hint: 'Enter 10-digit phone number',
                      errorText: _validationErrors['phoneNumber'],
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),

                    // Position field
                    _buildTextField(
                      controller: _positionController,
                      label: 'Position',
                      hint: 'Enter job position',
                      errorText: _validationErrors['position'],
                      icon: Icons.work,
                    ),
                    const SizedBox(height: 16),

                    // Department dropdown
                    _buildDropdownField(),
                    const SizedBox(height: 16),

                    // Salary field
                    _buildTextField(
                      controller: _salaryController,
                      label: 'Salary',
                      hint: 'Enter salary amount',
                      errorText: _validationErrors['salary'],
                      icon: Icons.monetization_on,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Date picker
                    _buildDatePicker(),
                    const SizedBox(height: 32),

                    // Submit button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          isEditMode ? 'Update Employee' : 'Add Employee',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /// Build text field widget with validation error display
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    String? errorText,
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: icon != null ? Icon(icon) : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            errorText: errorText,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  /// Build department dropdown field
  Widget _buildDropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Department', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _departmentController.text.isEmpty
              ? null
              : _departmentController.text,
          items: _departments
              .map((dept) => DropdownMenuItem(value: dept, child: Text(dept)))
              .toList(),
          onChanged: (value) {
            setState(() {
              _departmentController.text = value ?? '';
            });
          },
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.business),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            errorText: _validationErrors['department'],
          ),
        ),
      ],
    );
  }

  /// Build date picker field
  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Joining Date',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _pickDate,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.blueAccent),
                const SizedBox(width: 12),
                Text(DateFormat('MMM dd, yyyy').format(_selectedDate)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

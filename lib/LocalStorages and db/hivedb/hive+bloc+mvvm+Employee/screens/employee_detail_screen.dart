// lib/screens/employee_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/employee.dart';
import '../repositories/employee_repository.dart';
import '../viewmodels/employee_viewmodel.dart';

/// Employee Detail Screen - View layer in MVC
/// Displays detailed information about a single employee
class EmployeeDetailScreen extends StatefulWidget {
  final Employee employee;

  const EmployeeDetailScreen({Key? key, required this.employee})
      : super(key: key);

  @override
  State<EmployeeDetailScreen> createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  late EmployeeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    // ✅ CORRECT: Create ViewModel directly
    _viewModel = EmployeeViewModel(repository: EmployeeRepository());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile header card
            _buildProfileHeader(),
            const SizedBox(height: 24),

            // Personal information section
            _buildSectionTitle('Personal Information'),
            _buildDetailCard([
              _buildDetailRow('Email', widget.employee.email),
              _buildDetailRow('Phone',
                  _viewModel.formatPhoneNumber(widget.employee.phoneNumber)),
            ]),
            const SizedBox(height: 20),

            // Professional information section
            _buildSectionTitle('Professional Information'),
            _buildDetailCard([
              _buildDetailRow('Position', widget.employee.position),
              _buildDetailRow('Department', widget.employee.department),
              _buildDetailRow('Salary',
                  '₹${widget.employee.salary.toStringAsFixed(2)}'),
              _buildDetailRow(
                  'Joining Date',
                  DateFormat('MMM dd, yyyy').format(widget.employee.joiningDate)),
              _buildDetailRow(
                  'Years of Service',
                  '${_viewModel.calculateYearsOfService(widget.employee.joiningDate)} years'),
            ]),
            const SizedBox(height: 20),

            // Status section
            _buildSectionTitle('Status'),
            _buildDetailCard([
              _buildDetailRow(
                'Employee Status',
                widget.employee.isActive ? 'Active' : 'Inactive',
                valueColor:
                    widget.employee.isActive ? Colors.green : Colors.orange,
              ),
            ]),
            const SizedBox(height: 24),

            // Employee ID
            _buildSectionTitle('Employee ID'),
            _buildDetailCard([
              _buildDetailRow('ID', widget.employee.id),
            ]),
          ],
        ),
      ),
    );
  }

  /// Build profile header with avatar and basic info
  Widget _buildProfileHeader() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Avatar
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blueAccent,
              child: Text(
                _viewModel.getInitials(widget.employee.name),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Name
            Text(
              widget.employee.name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),

            // Position
            Text(
              widget.employee.position,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 4),

            // Department
            Text(
              widget.employee.department,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[500],
                  ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build section title
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
    );
  }

  /// Build detail card with multiple rows
  Widget _buildDetailCard(List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: children
              .toList()
              .asMap()
              .entries
              .map((entry) {
                final widget = entry.value;
                final isLastItem = entry.key == children.length - 1;
                return Column(
                  children: [
                    widget,
                    if (!isLastItem)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Divider(height: 1, color: Colors.grey[300]),
                      ),
                  ],
                );
              })
              .toList(),
        ),
      ),
    );
  }

  /// Build single detail row with label and value
  Widget _buildDetailRow(String label, String value,
      {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: valueColor ?? Colors.black87,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

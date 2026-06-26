// lib/viewmodels/employee_viewmodel.dart

import '../models/employee.dart';
import '../repositories/employee_repository.dart';

/// ViewModel for managing
/// employee data and business logic
/// This class acts as a bridge between
/// the BLoC/UI and Repository layers
/// It contains all business logic related
/// to employee operations
class EmployeeViewModel {
  final EmployeeRepository _repository;

  EmployeeViewModel
      ({required EmployeeRepository repository})
      : _repository = repository;

  /// Validate employee data before saving
  /// Returns a map of field names to
  /// error messages, empty if valid
  Map<String, String> validateEmployee({
    required String name,
    required String email,
    required String phoneNumber,
    required String position,
    required String department,
    required String salary,
  }) {
    final errors = <String, String>{};
    // Name validation
    if (name.trim().isEmpty) {
      errors['name'] = 'Name is required';
    } else if (name.length < 3) {
      errors['name'] = 'Name must be at '
          'least 3 characters';
    }

    // Email validation
    if (email.trim().isEmpty) {
      errors['email'] = 'Email is required';
    } else if (!_isValidEmail(email)) {
      errors['email'] = 'Please enter a '
          'valid email address';
    }

    // Phone number validation
    if (phoneNumber.trim().isEmpty) {
      errors['phoneNumber'] =
      'Phone number is required';
    } else if (!_isValidPhoneNumber(phoneNumber)) {
      errors['phoneNumber'] = 'Phone number must be '
          '10 digits';
    }

    // Position validation
    if (position.trim().isEmpty) {
      errors['position'] = 'Position is required';
    }

    // Department validation
    if (department.trim().isEmpty) {
      errors['department'] = 'Department is required';
    }

    // Salary validation
    if (salary.trim().isEmpty) {
      errors['salary'] = 'Salary is required';
    } else {
      try {
        final salaryValue = double.parse(salary);
        if (salaryValue <= 0) {
          errors['salary'] = 'Salary must be '
              'greater than 0';
        }
      } catch (e) {
        errors['salary'] = 'Please enter a valid '
            'salary amount';
      }
    }
    return errors;
  }

  /// Check if email format is valid using regex
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  /// Check if phone number is valid (10 digits)
  bool _isValidPhoneNumber(String phone) {
    final phoneRegex = RegExp(r'^\d{10}$');
    return phoneRegex.hasMatch(
        phone.replaceAll(RegExp(r'[^\d]'),''));
  }

  /// Calculate years of service
  /// Returns the number of years since joining date
  int calculateYearsOfService(DateTime joiningDate) {
    final today = DateTime.now();
    return today.year - joiningDate.year;
  }

  /// Format phone number for display
  /// Converts 10 digits to readable format: XXX-XXX-XXXX
  String formatPhoneNumber(String phone) {
    final cleaned = phone.replaceAll(RegExp(r'[^\d]'),'');
    if (cleaned.length == 10) {
      return '${cleaned.substring(0, 3)}-'
          '${cleaned.substring(3, 6)}-'
          '${cleaned.substring(6)}';
    }
    return phone;
  }

  /// Get initials from employee name
  /// Useful for avatar generation
  String getInitials(String name) {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'
          .toUpperCase();
    }
    return name.substring(0, 1).toUpperCase();
  }

  /// Calculate total payroll for all employees
  /// Returns the sum of all employee salaries
  Future<double> calculateTotalPayroll() async {
    final employees =
    await _repository.getAllEmployees();
    return employees.fold<double>(
        0.0, (sum, emp) => sum + emp.salary);
  }

  /// Get salary statistics
  /// Returns a map with average, min, and max salary
  Future<Map<String, double>> getSalaryStatistics() async {
    final employees = await _repository.getAllEmployees();
    if (employees.isEmpty) {
      return {'average': 0, 'min': 0, 'max': 0};
    }

    final salaries = employees.map((e) => e.salary).toList();
    salaries.sort();
    final average = salaries.fold<double>(0, (a, b) => a + b) / salaries.length;
    final min = salaries.first;
    final max = salaries.last;

    return {'average': average, 'min': min, 'max': max};
  }

  /// Get all unique departments
  /// Returns a list of departments where employees are assigned
  Future<List<String>> getAllDepartments() async {
    final employees = await _repository.getAllEmployees();
    final departments = <String>{};
    for (var emp in employees) {
      departments.add(emp.department);
    }
    return departments.toList()..sort();
  }

  /// Get department statistics
  /// Returns the count of employees in each department
  Future<Map<String, int>> getDepartmentStatistics() async {
    final employees = await _repository.getAllEmployees();
    final stats = <String, int>{};
    for (var emp in employees) {
      stats[emp.department] = (stats[emp.department] ?? 0) + 1;
    }
    return stats;
  }
}

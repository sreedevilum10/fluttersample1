// lib/repositories/employee_repository.dart

import 'package:hive/hive.dart';
import '../models/employee.dart';

/// Repository class for managing employee data using Hive
/// This class handles all CRUD operations and acts as a single source of truth
/// for employee data in the application
class EmployeeRepository {
  static const String _employeeBoxName = 'employees';

  /// Get or create the Hive box for employees
  Future<Box<Employee>> _getBox() async {
    if (Hive.isBoxOpen(_employeeBoxName)) {
      return Hive.box<Employee>(_employeeBoxName);
    }
    return await Hive.openBox<Employee>(_employeeBoxName);
  }

  /// Fetch all employees from local storage
  /// Returns a list of all employees currently stored in Hive
  Future<List<Employee>> getAllEmployees() async {
    try {
      final box = await _getBox();
      return box.values.toList();
    } catch (e) {
      throw Exception('Error fetching employees: $e');
    }
  }

  /// Fetch a single employee by ID
  /// Returns the employee if found, null otherwise
  Future<Employee?> getEmployeeById(String id) async {
    try {
      final box = await _getBox();
      // Search for employee with matching ID
      for (var employee in box.values) {
        if (employee.id == id) {
          return employee;
        }
      }
      return null;
    } catch (e) {
      throw Exception('Error fetching employee: $e');
    }
  }

  /// Create a new employee in the database
  /// Stores the employee in Hive box and returns the saved employee
  Future<void> createEmployee(Employee employee) async {
    try {
      final box = await _getBox();
      await box.add(employee);
    } catch (e) {
      throw Exception('Error creating employee: $e');
    }
  }
  /// Update an existing employee
  /// Finds the employee by ID and updates all fields
  Future<void> updateEmployee(Employee employee) async {
    try {
      final box = await _getBox();
      // Find the key of the employee with matching ID
      int? keyToUpdate;
      for (var entry in box.toMap().entries) {
        if (entry.value.id == employee.id) {
          keyToUpdate = entry.key;
          break;
        }
      }
      if (keyToUpdate != null) {
        await box.putAt(keyToUpdate, employee);
      } else {
        throw Exception('Employee not found');
      }
    } catch (e) {
      throw Exception('Error updating employee: $e');
    }
  }

  /// Delete an employee by ID
  /// Removes the employee from Hive storage
  Future<void> deleteEmployee(String id) async {
    try {
      final box = await _getBox();
      int? keyToDelete;
      for (var entry in box.toMap().entries) {
        if (entry.value.id == id) {
          keyToDelete = entry.key;
          break;
        }
      }
      if (keyToDelete != null) {
        await box.deleteAt(keyToDelete);
      } else {
        throw Exception('Employee not found');
      }
    } catch (e) {
      throw Exception('Error deleting employee: $e');
    }
  }

  /// Search employees by name (case-insensitive)
  /// Returns employees whose name contains the search query
  Future<List<Employee>> searchEmployeesByName(
      String query) async {
    try {
      final box = await _getBox();
      final results = <Employee>[];
      for (var employee in box.values) {
        if (employee.name.toLowerCase()
            .contains(query.toLowerCase())) {
          results.add(employee);
        }
      }
      return results;
    } catch (e) {
      throw Exception('Error searching employees: $e');
    }
  }

  /// Get employees by department
  /// Returns all employees in a specific department
  Future<List<Employee>> getEmployeesByDepartment(
      String department) async {
    try {
      final box = await _getBox();
      return box.values
          .where((emp) => emp.department == department)
          .toList();
    } catch (e) {
      throw Exception('Error fetching '
          'employees by department: $e');
    }
  }

  /// Get total count of employees
  Future<int> getEmployeeCount() async {
    try {
      final box = await _getBox();
      return box.length;
    } catch (e) {
      throw Exception('Error getting employee count: $e');
    }
  }

  /// Clear all employees (useful for testing
  /// or complete reset)
  Future<void> clearAllEmployees() async {
    try {
      final box = await _getBox();
      await box.clear();
    } catch (e) {
      throw Exception('Error clearing employees: $e');
    }
  }
}

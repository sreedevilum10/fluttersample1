// lib/models/employee.dart
import 'package:hive/hive.dart';
part 'employee.g.dart';

/// Employee Model for Hive database storage
/// This model represents an employee with all necessary information
@HiveType(typeId: 0)
class Employee extends HiveObject {
  /// Unique identifier for the employee
  @HiveField(0)
  late String id;

  /// Full name of the employee
  @HiveField(1)
  late String name;

  /// Email address of the employee
  @HiveField(2)
  late String email;

  /// Phone number of the employee
  @HiveField(3)
  late String phoneNumber;

  /// Position/Job title of the employee
  @HiveField(4)
  late String position;

  /// Department of the employee
  @HiveField(5)
  late String department;

  /// Salary of the employee
  @HiveField(6)
  late double salary;

  /// Date of joining
  @HiveField(7)
  late DateTime joiningDate;

  /// Employee status (active/inactive)
  @HiveField(8)
  late bool isActive;

  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.position,
    required this.department,
    required this.salary,
    required this.joiningDate,
    this.isActive = true,
  });

  /// Create a copy of Employee with modified fields
  Employee copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? position,
    String? department,
    double? salary,
    DateTime? joiningDate,
    bool? isActive,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      position: position ?? this.position,
      department: department ?? this.department,
      salary: salary ?? this.salary,
      joiningDate: joiningDate ?? this.joiningDate,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  String toString() {
    return 'Employee(id: $id, name: $name, email: $email, position: $position)';
  }
}

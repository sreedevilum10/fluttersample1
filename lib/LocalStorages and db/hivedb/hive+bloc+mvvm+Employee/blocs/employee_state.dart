// lib/blocs/employee_state.dart

import '../models/employee.dart';
/// Base class for all Employee BLoC states
abstract class EmployeeState {
  const EmployeeState();
}

/// Initial state when BLoC is created
class EmployeeInitial extends EmployeeState {
  const EmployeeInitial();
}

/// Loading state while performing operations
class EmployeeLoading extends EmployeeState {
  const EmployeeLoading();
}

/// Success state when employees are loaded
class EmployeeLoaded extends EmployeeState {
  final List<Employee> employees;
  const EmployeeLoaded(this.employees);

  @override
  bool operator == (Object other) =>
      identical(this, other) ||
      other is EmployeeLoaded &&
          runtimeType == other.runtimeType &&
          employees == other.employees;
  @override
  int get hashCode => employees.hashCode;
}

/// Success state when an employee is created
class EmployeeCreated extends EmployeeState {
  final Employee employee;
  const EmployeeCreated(this.employee);
}

/// Success state when an employee is updated
class EmployeeUpdated extends EmployeeState {
  final Employee employee;
  const EmployeeUpdated(this.employee);
}
/// Success state when an employee is deleted
class EmployeeDeleted extends EmployeeState {

  final String employeeId;
  const EmployeeDeleted(this.employeeId);
}

/// State when search results are available
class EmployeeSearchResults extends EmployeeState {

  final List<Employee> results;
  final String query;
  const EmployeeSearchResults({required this.results,
    required this.query});
}

/// Error state with error message
class EmployeeError extends EmployeeState {
  final String message;
  const EmployeeError(this.message);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeError &&
          runtimeType == other.runtimeType &&
          message == other.message;
  @override
  int get hashCode => message.hashCode;
}

/// State when salary statistics are available
class SalaryStatisticsLoaded extends EmployeeState {
  final Map<String, double> statistics; //'average', 'min', 'max'
  const SalaryStatisticsLoaded(this.statistics);
}

/// State when department statistics are available
class DepartmentStatisticsLoaded extends EmployeeState {
  final Map<String, int> statistics; // department -> count
  const DepartmentStatisticsLoaded(this.statistics);
}

/// State when employees are sorted
class EmployeeSorted extends EmployeeState {
  final List<Employee> employees;
  final String sortBy;
  final bool ascending;
  const EmployeeSorted({
    required this.employees,
    required this.sortBy,
    required this.ascending,
  });
}

/// State when no employees exist
class NoEmployeesFound extends EmployeeState {
  const NoEmployeesFound();
}

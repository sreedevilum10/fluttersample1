// lib/blocs/employee_event.dart

import '../models/employee.dart';

/// Base class for all Employee BLoC events
abstract class EmployeeEvent {
  const EmployeeEvent();
}

/// Event to fetch all employees from repository
class FetchEmployeesEvent extends EmployeeEvent {
  const FetchEmployeesEvent();
}

/// Event to add a new employee
class AddEmployeeEvent extends EmployeeEvent {
  final Employee employee;
  const AddEmployeeEvent(this.employee);
}

/// Event to update an existing employee
class UpdateEmployeeEvent extends EmployeeEvent {
  final Employee employee;
  const UpdateEmployeeEvent(this.employee);
}

/// Event to delete an employee by ID
class DeleteEmployeeEvent extends EmployeeEvent {
  final String employeeId;
  const DeleteEmployeeEvent(this.employeeId);
}

/// Event to search employees by name
class SearchEmployeesEvent extends EmployeeEvent {
  final String query;
  const SearchEmployeesEvent(this.query);
}

/// Event to filter employees by department
class FilterByDepartmentEvent extends EmployeeEvent {
  final String department;
  const FilterByDepartmentEvent(this.department);
}

/// Event to clear search/filter and show all employees
class ClearSearchEvent extends EmployeeEvent {
  const ClearSearchEvent();
}

/// Event to get employees by a specific department
class FetchEmployeesByDepartmentEvent extends EmployeeEvent {
  final String department;
  const FetchEmployeesByDepartmentEvent(this.department);
}

/// Event to sort employees by a specific field
class SortEmployeesEvent extends EmployeeEvent {
  final String sortBy; // 'name', 'salary', 'joinDate', 'department'
  final bool ascending;
  const SortEmployeesEvent({required this.sortBy,
    required this.ascending});
}

/// Event to get salary statistics
class FetchSalaryStatisticsEvent extends EmployeeEvent {
  const FetchSalaryStatisticsEvent();
}

/// Event to get department statistics
class FetchDepartmentStatisticsEvent extends EmployeeEvent {
  const FetchDepartmentStatisticsEvent();
}

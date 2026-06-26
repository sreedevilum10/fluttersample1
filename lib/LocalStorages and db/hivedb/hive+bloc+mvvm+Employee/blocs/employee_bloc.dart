// lib/blocs/employee_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/employee.dart';
import '../repositories/employee_repository.dart';
import '../viewmodels/employee_viewmodel.dart';
import 'employee_event.dart';
import 'employee_state.dart';

/// BLoC for managing employee operations
/// This class handles all events and emits
/// appropriate states It uses the ViewModel
/// for business logic and Repository for data access
class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final EmployeeRepository _repository;
  final EmployeeViewModel _viewModel;

  /// List to store current employees in memory
  List<Employee> _allEmployees = [];

  EmployeeBloc({
    required EmployeeRepository repository,
    required EmployeeViewModel viewModel,
  })  : _repository = repository,
        _viewModel = viewModel,
        super(const EmployeeInitial()) {
    // Register event handlers
    on<FetchEmployeesEvent>(_onFetchEmployees);
    on<AddEmployeeEvent>(_onAddEmployee);
    on<UpdateEmployeeEvent>(_onUpdateEmployee);
    on<DeleteEmployeeEvent>(_onDeleteEmployee);
    on<SearchEmployeesEvent>(_onSearchEmployees);
    on<ClearSearchEvent>(_onClearSearch);
    on<FetchEmployeesByDepartmentEvent>
      (_onFetchByDepartment);
    on<SortEmployeesEvent>(_onSortEmployees);
    on<FetchSalaryStatisticsEvent>
      (_onFetchSalaryStatistics);
    on<FetchDepartmentStatisticsEvent>
      (_onFetchDepartmentStatistics);
  }

  /// Handle FetchEmployeesEvent
  /// Retrieves all employees from repository and emits EmployeeLoaded state
  Future<void> _onFetchEmployees(
    FetchEmployeesEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      emit(const EmployeeLoading());
      _allEmployees = await _repository
          .getAllEmployees();
      if (_allEmployees.isEmpty) {
        emit(const NoEmployeesFound());
      } else {
        emit(EmployeeLoaded(_allEmployees));
      }
    } catch (e) {
      emit(EmployeeError('Failed to fetch employees:'
          '${e.toString()}'));
    }
  }

  /// Handle AddEmployeeEvent
  /// Creates a new employee and adds to repository
  Future<void> _onAddEmployee(
    AddEmployeeEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      emit(const EmployeeLoading());
      await _repository.createEmployee(event.employee);
      _allEmployees.add(event.employee);
      emit(EmployeeCreated(event.employee));
      // Fetch updated list
      add(const FetchEmployeesEvent());
    } catch (e) {
      emit(EmployeeError('Failed to create employee: '
          '${e.toString()}'));
    }
  }

  /// Handle UpdateEmployeeEvent
  /// Updates existing employee in repository
  Future<void> _onUpdateEmployee(
      UpdateEmployeeEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      emit(const EmployeeLoading());
      await _repository.updateEmployee(event.employee);
      // Update in local list
      final index = _allEmployees.indexWhere((e) =>
      e.id == event.employee.id);
      if (index != -1) {
        _allEmployees[index] = event.employee;
      }
      emit(EmployeeUpdated(event.employee));
      // Fetch updated list
      add(const FetchEmployeesEvent());
    } catch (e) {
      emit(EmployeeError('Failed to update employee:'
          ' ${e.toString()}'));
    }
  }

  /// Handle DeleteEmployeeEvent
  /// Deletes employee from repository
  Future<void> _onDeleteEmployee(
    DeleteEmployeeEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      emit(const EmployeeLoading());
      await _repository.deleteEmployee(event.employeeId);
      _allEmployees.removeWhere((e) => e.id
          == event.employeeId);
      emit(EmployeeDeleted(event.employeeId));
      // Fetch updated list
      add(const FetchEmployeesEvent());
    } catch (e) {
      emit(EmployeeError('Failed to delete employee: '
          '${e.toString()}'));
    }
  }

  /// Handle SearchEmployeesEvent
  /// Searches employees by name using repository
  Future<void> _onSearchEmployees(
    SearchEmployeesEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      emit(const EmployeeLoading());
      final results =
      await _repository.searchEmployeesByName(
          event.query);
      emit(EmployeeSearchResults(
          results: results, query: event.query));
    } catch (e) {
      emit(EmployeeError('Failed to search employees:'
          '${e.toString()}'));
    }
  }
  /// Handle ClearSearchEvent
  /// Clears search results and shows all employees
  Future<void> _onClearSearch(
    ClearSearchEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      if (_allEmployees.isEmpty) {
        emit(const NoEmployeesFound());
      } else {
        emit(EmployeeLoaded(_allEmployees));
      }
    } catch (e) {
      emit(EmployeeError('Failed to clear search: '
          '${e.toString()}'));
    }
  }

  /// Handle FetchEmployeesByDepartmentEvent
  /// Filters employees by department
  Future<void> _onFetchByDepartment(
    FetchEmployeesByDepartmentEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      emit(const EmployeeLoading());
      final results =
          await _repository.getEmployeesByDepartment(event.department);

      if (results.isEmpty) {
        emit(const NoEmployeesFound());
      } else {
        emit(EmployeeLoaded(results));
      }
    } catch (e) {
      emit(EmployeeError('Failed to fetch employees: ${e.toString()}'));
    }
  }

  /// Handle SortEmployeesEvent
  /// Sorts employees by specified field
  Future<void> _onSortEmployees(
    SortEmployeesEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      final sorted = List<Employee>.from(_allEmployees);

      // Sort based on sortBy parameter
      switch (event.sortBy) {
        case 'name':
          sorted.sort((a, b) =>
              event.ascending ? a.name.compareTo(b.name) : b.name.compareTo(a.name));
          break;
        case 'salary':
          sorted.sort((a, b) =>
              event.ascending ? a.salary.compareTo(b.salary) : b.salary.compareTo(a.salary));
          break;
        case 'joinDate':
          sorted.sort((a, b) => event.ascending
              ? a.joiningDate.compareTo(b.joiningDate)
              : b.joiningDate.compareTo(a.joiningDate));
          break;
        case 'department':
          sorted.sort((a, b) => event.ascending
              ? a.department.compareTo(b.department)
              : b.department.compareTo(a.department));
          break;
      }

      emit(EmployeeSorted(
        employees: sorted,
        sortBy: event.sortBy,
        ascending: event.ascending,
      ));
    } catch (e) {
      emit(EmployeeError('Failed to sort employees: ${e.toString()}'));
    }
  }

  /// Handle FetchSalaryStatisticsEvent
  /// Calculates and emits salary statistics
  Future<void> _onFetchSalaryStatistics(
    FetchSalaryStatisticsEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      emit(const EmployeeLoading());
      final stats = await _viewModel.getSalaryStatistics();
      emit(SalaryStatisticsLoaded(stats));
    } catch (e) {
      emit(EmployeeError('Failed to fetch statistics: ${e.toString()}'));
    }
  }

  /// Handle FetchDepartmentStatisticsEvent
  /// Calculates and emits department statistics
  Future<void> _onFetchDepartmentStatistics(
    FetchDepartmentStatisticsEvent event,
    Emitter<EmployeeState> emit,
  ) async {
    try {
      emit(const EmployeeLoading());
      final stats = await _viewModel.getDepartmentStatistics();
      emit(DepartmentStatisticsLoaded(stats));
    } catch (e) {
      emit(EmployeeError('Failed to fetch statistics: ${e.toString()}'));
    }
  }
}

// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'blocs/employee_bloc.dart';
import 'models/employee.dart';
import 'repositories/employee_repository.dart';
import 'screens/employee_list_screen.dart';
import 'viewmodels/employee_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(EmployeeAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create instances
    final employeeRepository = EmployeeRepository();
    final employeeViewModel =
    EmployeeViewModel(repository: employeeRepository);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<EmployeeRepository>
            .value(value: employeeRepository),
        RepositoryProvider<EmployeeViewModel>
            .value(value: employeeViewModel),
      ],
      child: BlocProvider(
        create: (_) => EmployeeBloc(
          repository: employeeRepository,
          viewModel: employeeViewModel,
        ),
        child: MaterialApp(home:
        const EmployeeListScreen()),
      ),
    );
  }
}

// ============================================================
// APP ENTRY POINT
// Wires up: ApiService -> Repository -> Bloc -> Screen
// ============================================================

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'service/api_service.dart';
import 'repository/user_repository.dart';
import 'bloc/user_bloc.dart';
import 'bloc/user_event.dart';
import 'view/user_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Users App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: BlocProvider(
        // Build the dependency chain: Service -> Repository -> Bloc
        create: (_) => UserBloc(
          repository: UserRepository(apiService: ApiService()),
        )..add(FetchUsers()), // Dispatch event right after creation
        child: const UserScreen(),
      ),
    );
  }
}

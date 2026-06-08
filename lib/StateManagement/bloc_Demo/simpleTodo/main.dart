// Import Flutter Material package.
// Contains MaterialApp, ThemeData, Colors, etc.
import 'package:flutter/material.dart';
// Import flutter_bloc package.
// Provides BlocProvider and other BLoC utilities.
import 'package:flutter_bloc/flutter_bloc.dart';
// Import TodoBloc class.
import 'package:fluttersample1/StateManagement/bloc_Demo/simpleTodo/bloc/todo_bloc.dart';
import 'package:fluttersample1/StateManagement/bloc_Demo/simpleTodo/view/todo_screen.dart';
// Import TodoScreen UI.

// Application starting point.
//
// Execution starts from main().
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLoC Todo',
      debugShowCheckedModeBanner: false,
      // Application theme.
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      // First screen shown when app starts.
      home: BlocProvider(
        // Create and provide TodoBloc
        // to all child widgets.
        create: (_) => TodoBloc(),
        // Child widget that can access TodoBloc.
        child: TodoScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/counter_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

/// Root widget — wraps the entire app with ChangeNotifierProvider
/// so every widget inside can access CounterProvider.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // 'create' is called once; Provider disposes it automatically.
      create: (context) => CounterProvider(),
      child: MaterialApp(
        title: 'Session 1 – Provider Setup',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home:  HomeScreen(),
      ),
    );
  }
}

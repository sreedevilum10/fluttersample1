import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

// Main entry point - runs when app starts
void main() {
  // runApp starts the Flutter application
  runApp(const MyApp());
}

// MyApp is the root widget that configures entire app
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // App title shown in task switcher
      title: 'User Settings Manager',
      
      // Configure global theme
      theme: ThemeData(
        // Light theme colors
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      
      // Dark theme configuration
      darkTheme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      
      // Home page - first screen shown
      home: const HomeScreen(),
      
      // Disable debug banner
      debugShowCheckedModeBanner: false,
    );
  }
}

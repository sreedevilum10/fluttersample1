import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  // Method to change theme
  void _changeTheme(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // 👇 Theme Mode
      themeMode: _themeMode,

      // 👇 Light Theme
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),

      // 👇 Dark Theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),

      home: HomeScreen(
        currentTheme: _themeMode,
        onThemeChanged: _changeTheme,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final ThemeMode currentTheme;
  final Function(ThemeMode) onThemeChanged;

  const HomeScreen({
    super.key,
    required this.currentTheme,
    required this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Theme Switcher"),

        // 👇 Button in AppBar
        actions: [
          PopupMenuButton<ThemeMode>(
            icon: Icon(Icons.color_lens),
            onSelected: (ThemeMode mode) {
              onThemeChanged(mode);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: ThemeMode.light,
                child: Text("Light Mode"),
              ),
              PopupMenuItem(
                value: ThemeMode.dark,
                child: Text("Dark Mode"),
              ),
              PopupMenuItem(
                value: ThemeMode.system,
                child: Text("System Mode"),
              ),
            ],
          ),
        ],
      ),

      body: Center(
        child: Text(
          "Current Theme: ${currentTheme.name.toUpperCase()}",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
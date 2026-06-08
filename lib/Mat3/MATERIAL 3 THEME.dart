// ==========================
// MATERIAL 3 THEME DEMO
// ==========================

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Theme Creator
ThemeData createMaterial3Theme(Color seedColor, Brightness brightness) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: createMaterial3Theme(Colors.blue, Brightness.light),
      darkTheme: createMaterial3Theme(Colors.blue, Brightness.dark),
      home: Scaffold(
        appBar: AppBar(title: Text("Material 3 Theme")),
        body: Center(child: Text("Hello Material 3")),
      ),
    );
  }
}
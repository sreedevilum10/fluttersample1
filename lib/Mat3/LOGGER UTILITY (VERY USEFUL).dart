// ==========================
// LOGGER UTILITY
// ==========================
import 'package:flutter/material.dart';
import 'dart:developer'; // for log()

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Log Demo',
      home: LogScreen(),
    );
  }
}

class LogScreen extends StatelessWidget {
  void handleButtonClick() {
    // Basic log
    print("Button clicked using print");

    // Advanced log
    log("Button clicked using log()", name: "BUTTON_EVENT");

    // Logging with error example
    try {
      int result = 10 ~/ 0; // will cause error
      print(result);
    } catch (e, stackTrace) {
      log(
        "Error occurred",
        error: e,
        stackTrace: stackTrace,
        name: "ERROR_LOG",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Logging Example"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: handleButtonClick,
          child: Text("Click Me"),
        ),
      ),
    );
  }
}
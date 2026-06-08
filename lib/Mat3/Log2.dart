import 'package:flutter/material.dart';
import 'dart:developer';

void main() {
  runApp(MyApp());
}

/// 🔹 Custom Logger Helper
class AppLogger {
  static void info(String message) {
    log(message, name: "INFO");
  }

  static void warning(String message) {
    log(message, name: "WARNING");
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    log(
      message,
      name: "ERROR",
      error: error,
      stackTrace: stackTrace,
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Log Levels Demo',
      home: LogScreen(),
    );
  }
}

class LogScreen extends StatelessWidget {
  void handleButtonClick() {
    // ✅ Info log
    AppLogger.info("Button clicked");

    // ✅ Warning log
    AppLogger.warning("This is a warning message");

    // ❌ Error log
    try {
      int result = 10 ~/ 0; // force error
      print(result);
    } catch (e, stackTrace) {
      AppLogger.error(
        "Something went wrong!",
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log Levels Example"),
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
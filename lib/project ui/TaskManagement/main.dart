import 'package:flutter/material.dart';
import 'package:fluttersample1/project%20ui/TaskManagement/views/home_screen.dart';
import 'package:get/get.dart';
import 'controllers/task_controller.dart';

void main() {
  // Initialize controller directly
  Get.put(TaskController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: HomeScreenTask(),
      debugShowCheckedModeBanner: false,
    );
  }
}

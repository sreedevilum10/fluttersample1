import 'package:flutter/material.dart';
import 'package:fluttersample1/StateManagement/getx/getxCounter/view/homeView.dart';
import 'package:get/get.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeViewGet(),
    );
  }
}
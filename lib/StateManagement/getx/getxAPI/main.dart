import 'package:flutter/material.dart';
import 'package:fluttersample1/StateManagement/getx/getxAPI/screen/home_view.dart';
import 'package:get/get.dart';

void main() {

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:  HomeViewGet2(),
    );
  }
}
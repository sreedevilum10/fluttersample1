import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'viewmodel/product_controller.dart';
import 'view/home_screen.dart';

void main() {
  // Register controller before runApp — prevents any Obx timing issues
  Get.put(ProductController(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ShopX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey.shade50,
      ),
      home: const HomeScreen(),
    );
  }
}

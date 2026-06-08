import 'package:flutter/material.dart';
import 'package:fluttersample1/StateManagement/ProviderDemos/LoginProvider/provider/auth_provider.dart' show AuthProvider;
import 'package:fluttersample1/StateManagement/ProviderDemos/LoginProvider/view/login_screen.dart' show LoginScreen;
import 'package:provider/provider.dart';

void main() {

  runApp(

    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
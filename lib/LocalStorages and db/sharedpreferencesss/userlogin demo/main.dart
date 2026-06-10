import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SharedPreferences Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const LoginPage(),  // ✅ Keep this
      routes: {
        '/home': (context) => const HomePage(),  // ✅ Only other routes
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
import 'package:flutter/material.dart';

class HomeScreenHive extends StatelessWidget {
  final String username;
  const HomeScreenHive({super.key, required this.username,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Text(
          "Welcome $username",
          style: const TextStyle(
            fontSize: 24,
            fontWeight:
            FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
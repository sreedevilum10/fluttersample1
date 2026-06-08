import 'package:flutter/material.dart';

class HomeScreenLog extends StatelessWidget {
  const HomeScreenLog({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),

      body: const Center(
        child: Text(
          "Login Successful",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
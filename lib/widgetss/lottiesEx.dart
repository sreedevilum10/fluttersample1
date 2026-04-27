import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            // Load a Lottie file from your assets
            Lottie.asset('assets/animation/handAni.json',height: 200,width: 200),
            // Load a Lottie file from a remote url
            Lottie.network(
              'https://lottie.host/f564d843-556e-4a30-9a5c-0534f2c47579/27VX0Un61o.json',
            ),

          ],
        ),
      ),
    );
  }
}
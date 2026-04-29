import 'package:flutter/material.dart';
import 'package:fluttersample1/customthemeandMateria3widget/theme/typographytheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // 🌞 Light Theme
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        textTheme: AppTextTheme.lightTextTheme,
      ),

      // 🌙 Dark Theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        textTheme: AppTextTheme.darkTextTheme,
      ),

      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Typography (Separated File)"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Headline
            Text(
              "Screen Title",
              style: textTheme.headlineLarge,
            ),

            const SizedBox(height: 16),

            // ✅ Subtitle
            Text(
              "Subtitle using titleMedium",
              style: textTheme.titleMedium,
            ),

            const SizedBox(height: 16),

            // ✅ Body text
            Text(
              "This text comes from AppTextTheme",
              style: textTheme.bodyLarge,
            ),

            const SizedBox(height: 16),

            // ✅ copyWith usage
            Text(
              "Emphasized Text",
              style: textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.primary,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Button Text",
                style: textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
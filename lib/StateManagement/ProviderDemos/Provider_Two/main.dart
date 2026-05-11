import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      // Consumer<ThemeProvider> wraps MaterialApp so the theme
      // reacts instantly when the user toggles light/dark.
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Session 2 – Consumer Widget',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.themeMode,
            theme: ThemeData(
              primarySwatch: themeProvider.selectedSwatch,
              brightness: Brightness.light,
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              primarySwatch: themeProvider.selectedSwatch,
              brightness: Brightness.dark,
              useMaterial3: true,
            ),
            home:  HomeScreen(),
          );
        },
      ),
    );
  }
}

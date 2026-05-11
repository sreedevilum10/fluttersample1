import 'package:flutter/material.dart';

/// ThemeProvider manages the app's visual theme (light / dark).
/// Demonstrates a real-world ChangeNotifier with multiple state fields.
class ThemeProvider extends ChangeNotifier {
  // ── State ──────────────────────────────────────────────────────
  ThemeMode _themeMode = ThemeMode.light;
  String _accentColor = 'Blue';

  // ── Getters ────────────────────────────────────────────────────
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  String get accentColor => _accentColor;

  /// Returns a MaterialColor based on the chosen accent name.
  MaterialColor get selectedSwatch {
    switch (_accentColor) {
      case 'Red':
        return Colors.red;
      case 'Green':
        return Colors.green;
      case 'Purple':
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }

  // ── Methods ────────────────────────────────────────────────────
  /// Toggles between light and dark mode.
  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light
            ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  /// Updates the accent color used across the app.
  void setAccentColor(String color) {
    _accentColor = color;
    notifyListeners();
  }
}

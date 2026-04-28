import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryPurple = Color(0xFF6750A4);
  static const Color secondaryTeal = Color(0xFF009688);
  static const Color errorRed = Color(0xFFB3261E);
  static const Color background = Color(0xFE9A9012);
  static const Color surface = Color(0xff2df31f);
}

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primaryPurple,
    onPrimary: Colors.white,
    secondary: AppColors.secondaryTeal,
    surface: Color(0xFFFFFBFE),
    onSurface: Color(0xFF1C1B1F),
    error: AppColors.errorRed,
  ),

 // scaffoldBackgroundColor: AppColors.background,

  // elevatedButtonTheme: ElevatedButtonThemeData(
  //   style: ElevatedButton.styleFrom(
  //     backgroundColor: AppColors.secondaryTeal,
  //     shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(15)),
  //     padding: EdgeInsets.symmetric(
  //         horizontal: 25, vertical: 14),
  //   ),
  // ),
);

import 'package:flutter/material.dart';
import 'package:fluttersample1/customthemeandMateria3widget/theme/ApptextStyle.dart';
import 'package:fluttersample1/customthemeandMateria3widget/theme/appcolors.dart';
import 'package:fluttersample1/customthemeandMateria3widget/theme/buttonstyle.dart';

void main() {
  runApp(MyApp());
}

// Root widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Theme Demo',
      // 🔥 THEME DEFINITION
      theme: lightTheme,

      // ThemeData(
      //   useMaterial3: true,
      //   // Generate full color palette from one color
      //   colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF13224E)),
      // ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access theme anywhere
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Theme Example",
          style: Theme.of(context)
              .textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontFamily: 'Great Vibes',
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              // ✅ Use theme colors (never hardcode)
              color: colors.onPrimaryContainer,
              child: Text("Hello Theme!", style: Apptextstyle.bodyText),
            ),
            ElevatedButton(
              style: AppButtonStyle.elevatedButton,
              onPressed: () {},
              child: Text("Hello"),
            ),
          ],
        ),
      ),
    );
  }
}

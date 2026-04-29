import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

enum ScreenSize { mobile, tablet, desktop }

ScreenSize getSize(BuildContext context) {
  double width = MediaQuery.of(context).size.width;

  if (width < 600) return ScreenSize.mobile;
  if (width < 1200) return ScreenSize.tablet;
  return ScreenSize.desktop;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    switch (getSize(context)) {
      case ScreenSize.mobile:
        return Scaffold(body: Center(child: Text("Mobile")));
      case ScreenSize.tablet:
        return Scaffold(body: Center(child: Text("Tablet")));
      case ScreenSize.desktop:
        return Scaffold(body: Center(child: Text("Desktop")));
    }
  }
}

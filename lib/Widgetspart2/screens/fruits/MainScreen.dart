// ================= APP =================
import 'package:flutter/material.dart';
import 'package:fluttersample1/Widgetspart2/screens/fruits/DetailsPafe.dart';
import 'package:fluttersample1/Widgetspart2/screens/fruits/HomePage.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {   // each screen
        '/': (context) => Homepage(),
        '/details': (context) => Detailspage(),
      },
    );
  }
}
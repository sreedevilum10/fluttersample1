// ================= APP =================
import 'package:flutter/material.dart';
import 'package:fluttersample1/Widgetspart2/screens/DetailsPafe.dart';
import 'package:fluttersample1/Widgetspart2/screens/HomePage.dart';


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
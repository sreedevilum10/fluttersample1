import 'package:flutter/material.dart';
import 'package:fluttersample1/widgetss/carousal%20slider%20in%20flutter.dart';
import 'Widgetspart2/screens/product/detail.dart';
import 'Widgetspart2/screens/product/mainScreen.dart';


void main() =>
    runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CarousalSliderDemo()));
//
// void main() => runApp(ProductMyApp());
//
// class ProductMyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Ecommerce UI",
//       theme: ThemeData(primarySwatch: Colors.deepPurple),
//       home: MainPage(),
//       routes: {
//         '/details': (context) => ProductDetailsPage()
//       },
//     );
//   }
// }
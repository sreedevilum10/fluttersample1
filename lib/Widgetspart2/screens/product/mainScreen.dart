// ================= APP =================
import 'package:flutter/material.dart';
import 'package:fluttersample1/Widgetspart2/screens/product/cart.dart';
import 'package:fluttersample1/Widgetspart2/screens/product/category.dart';
import 'package:fluttersample1/Widgetspart2/screens/product/home.dart';
import 'package:fluttersample1/Widgetspart2/screens/product/profil.dart';

// ================= MAIN PAGE =================
class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final pages = [
    ProductHomePage(),
    ProductCategoryPage(),
    ProductCartPage(),
    ProductProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      // 🧭 Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.shifting,
        //backgroundColor: Colors.blue,
        //fixedColor: Colors.yellow,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        elevation: 18,
        onTap: (index) {
          setState(() => currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

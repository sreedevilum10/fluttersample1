// ================= CART =================
import 'package:flutter/material.dart';

class ProductCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: Center(child: Text("Your cart is empty")),
    );
  }
}

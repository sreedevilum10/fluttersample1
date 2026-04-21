// ================= DETAILS =================
import 'package:flutter/material.dart';

import '../../model/productmodel/product.dart';

class ProductDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(product.image, height: 150, fit: BoxFit.cover),

            SizedBox(height: 20),
            Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            Text(
              "₹${product.price}",
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),

            SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart),
              label: Text("Add to Cart"),
            ),
          ],
        ),
      ),
    );
  }
}

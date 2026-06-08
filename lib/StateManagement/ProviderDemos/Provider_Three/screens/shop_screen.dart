import 'package:flutter/material.dart';
import 'package:fluttersample1/StateManagement/ProviderDemos/Provider_Three/widgets/productCard.dart';


/// Static product catalogue for demo purposes.
const products = [
  {'id': 'p1', 'name': 'Flutter T-Shirt', 'price': 24.99},
  {'id': 'p2', 'name': 'Dart Mug', 'price': 12.99},
  {'id': 'p3', 'name': 'Widget Poster', 'price': 8.99},
  {'id': 'p4', 'name': 'Firebase Sticker Pack', 'price': 4.99},
  {'id': 'p5', 'name': 'Provider Hoodie', 'price': 39.99},
  {'id': 'p6', 'name': 'Riverpod Notebook', 'price': 14.99},
];

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shop')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(product: product);
        },
      ),
    );
  }
}



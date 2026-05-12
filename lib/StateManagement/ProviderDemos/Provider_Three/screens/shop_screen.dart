import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

/// Static product catalogue for demo purposes.
const _products = [
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
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return _ProductCard(product: product);
        },
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Icon(Icons.inventory_2,
                    size: 48, color: Theme.of(context).colorScheme.primary),
              ),
            ),
            Text(
              product['name'] as String,
              style: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              '\$${product['price']}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.read<CartProvider>().addItem(
                      product['id'] as String,
                      product['name'] as String,
                      product['price'] as double,
                    ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                ),
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

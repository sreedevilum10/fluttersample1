import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersample1/StateManagement/ProviderDemos/Provider_Six-%20Riverpod/providers/providers.dart';
import 'package:fluttersample1/StateManagement/ProviderDemos/Provider_Six-%20Riverpod/screens/cartScreen.dart';
import 'package:fluttersample1/StateManagement/ProviderDemos/Provider_Six-%20Riverpod/screens/wishlistScreen.dart';

import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productProvider);
    final cartItems = ref.watch(cartProvider);
    final wishlistItems = ref.watch(wishlistProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Riverpod Shop"),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) =>
                    const CartScreenn()),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
              ),

              Positioned(
                right: 5,
                top: 5,
                child: CircleAvatar(
                  radius: 8,
                  child: Text(
                    cartItems.length.toString(),
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              ),
            ],
          ),

          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>
                const WishlistScreen()),
              );
            },

            icon: const Icon(Icons.favorite),
          ),
        ],
      ),

      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            child: ListTile(
              title: Text(product.title),
              subtitle: Text("₹${product.price}"),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      ref.read(cartProvider.notifier)
                          .addToCart(product);
                    },
                    icon: const Icon(Icons.shopping_cart),
                  ),

                  IconButton(
                    onPressed: () {
                      ref
                          .read(wishlistProvider.notifier)
                          .addToWishlist(product);
                    },

                    icon: const Icon(Icons.favorite),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

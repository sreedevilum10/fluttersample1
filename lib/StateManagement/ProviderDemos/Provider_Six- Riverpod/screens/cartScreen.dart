
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';

class CartScreenn extends ConsumerWidget {
  const CartScreenn({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final cartItems = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),

      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return ListTile(
            title: Text(item.title),
            subtitle: Text("₹${item.price}"),
            trailing: IconButton(
              onPressed: () {
                ref
                    .read(cartProvider.notifier)
                    .removeFromCart(item);
              },

              icon: const Icon(Icons.delete),
            ),
          );
        },
      ),
    );
  }
}
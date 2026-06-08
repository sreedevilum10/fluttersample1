import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing MULTIPLE providers in one view
    final auth = context.watch<AuthProvider>();
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("${auth.displayName}'s Cart"),
        actions: [
          if (!cart.isEmpty)
            TextButton(
              onPressed: () =>
                  context.read<CartProvider>().clearCart(),
              child: const Text('Clear All',
                  style: TextStyle(color: Colors.red)),
            ),
        ],
      ),
      body: cart.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 64, color: Colors.grey),
                  SizedBox(height: 12),
                  Text('Your cart is empty',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey)),
                ],
              ),
            )
          : Column(
              children: [
                // ── Cart Items List ───────────────────────────────
                Expanded(
                  child: ListView(
                    children: cart.items.values.map((item) {
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text(
                            '\$${item.price.toStringAsFixed(2)} each'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                  Icons.remove_circle_outline),
                              onPressed: () => context
                                  .read<CartProvider>()
                                  .decreaseQuantity(item.id),
                            ),
                            Text('${item.quantity}',
                                style: const TextStyle(
                                    fontSize: 16)),
                            IconButton(
                              icon: const Icon(
                                  Icons.add_circle_outline),
                              onPressed: () => context
                                  .read<CartProvider>()
                                  .addItem(
                                  item.id,
                                  item.name,
                                  item.price),
                            ),
                            IconButton(
                              icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red),
                              onPressed: () => context
                                  .read<CartProvider>()
                                  .removeItem(item.id),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),

                // ── Total & Checkout ──────────────────────────────
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: const Offset(0, -2))
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Total: \$${cart
                              .totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                content: Text('Order placed! (demo)')),
                          );
                          context.read<CartProvider>().clearCart();
                          Navigator.pop(context);
                        },
                        child: const Text('Checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

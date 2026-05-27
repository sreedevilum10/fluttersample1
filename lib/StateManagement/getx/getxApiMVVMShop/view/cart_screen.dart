// lib/view/cart_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodel/product_controller.dart';
import 'widgets.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProductController>();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade800,
        foregroundColor: Colors.white,
        title: const Text('My Cart'),
      ),
      body: Obx(() {
        // Group cart items by product ID
        final Map<int, dynamic> grouped = {};
        for (final p in c.cart) {
          grouped[p.id] = p;
        }

        if (grouped.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.shopping_cart_outlined,
                    size: 70, color: Colors.grey.shade300),
                const SizedBox(height: 12),
                const Text('Your cart is empty',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Add products from the home view',
                    style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: Get.back,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white),
                  child: const Text('Browse Products'),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: grouped.length,
                itemBuilder: (_, i) {
                  final id = grouped.keys.elementAt(i); // product id at current position
                  final p  = grouped[id]!;// product using this id
                  final qty = c.cartCount(id);// count of product in that particular id
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 6)
                        ]),
                    child: Row(
                      children: [
                        // Thumbnail
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            width: 70, height: 70,
                            child: ProductImage(
                                url: p.thumbnail,
                                height: 70),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p.title,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 4),
                              Text('\$${p.finalPrice.toStringAsFixed(2)}'
                                  ' each',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.deepPurple)),
                              const SizedBox(height: 6),
                              // Qty controls
                              Row(
                                children: [
                                  _Btn(icon: Icons.remove,
                                      onTap: () => c.removeOneFromCart(id)),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Text('$qty',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepPurple)),
                                  ),
                                  _Btn(icon: Icons.add,
                                      onTap: () => c.addToCart(p)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // Total + delete
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '\$${(p.finalPrice * qty).toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () => c.removeAllFromCart(id),
                              child: const Icon(Icons.delete_outline,
                                  color: Colors.red, size: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // ── Total ───────────────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 28),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 10,
                      offset: const Offset(0, -2))
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${c.totalCartItems} items',
                          style: const TextStyle(color: Colors.grey)),
                      Text('\$${c.cartTotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.snackbar(
                        '🎉 Order Placed!',
                        'Your order has been confirmed.',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.green.shade700,
                        colorText: Colors.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(12)),
                      ),
                      child: Text(
                        'Checkout — \$${
                            c.cartTotal.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _Btn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _Btn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 26, height: 26,
          decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(6)),
          child: Icon(icon, size: 14, color: Colors.deepPurple),
        ),
      );
}

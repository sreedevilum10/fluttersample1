import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersample1/StateManagement/ProviderDemos/Riverpod_Api_FakeStore/provider/productProviders.dart';


class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProviderFake);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),

      body: cartItems.isEmpty
          ? const Center(
        child: Text("Cart is Empty"),
      )
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];

          return ListTile(
            leading: Image.network(
              item.image,
              width: 50,
            ),
            title: Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text("\$${item.price}"),
          );
        },
      ),
    );
  }
}
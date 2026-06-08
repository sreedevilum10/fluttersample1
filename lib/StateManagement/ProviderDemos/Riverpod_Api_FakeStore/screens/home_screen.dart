import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersample1/StateManagement/ProviderDemos/Riverpod_Api_FakeStore/provider/productProviders.dart';
import 'cart_screen.dart';

class HomeScreenFake extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productProvider);
    final cartItems = ref.watch(cartProviderFake);

    return Scaffold(
      appBar: AppBar(
        title: const Text("FakeStore"),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CartScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
              ),

              Positioned(
                right: 5,
                top: 5,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.red,
                  child: Text(
                    cartItems.length.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),

      body: products.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final product = data[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Image.network(
                        product.image,
                        width: 80,
                        height: 80,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              "\$${product.price}",
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 18,
                              ),
                            ),

                            const SizedBox(height: 10),

                            ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(cartProviderFake.notifier)
                                    .addToCart(product);

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content:
                                    Text("Added to cart"),
                                  ),
                                );
                              },
                              child: const Text("Add to Cart"),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },

        error: (e, _) => Center(
          child: Text(e.toString()),
        ),

        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
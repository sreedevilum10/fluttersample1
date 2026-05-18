import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/wishlist_provider.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistItems = ref.watch(wishlistProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Wishlist")),
      body: ListView.builder(
        itemCount: wishlistItems.length,
        itemBuilder: (context, index) {
          final item = wishlistItems[index];
          return Card(
            child: ListTile(
              title: Text(item.title),
              subtitle: Text("₹${item.price}"),
              trailing: IconButton(
                onPressed: () {
                  ref.read(wishlistProvider.notifier)
                      .removeFromWishlist(item);
                },

                icon: const Icon(Icons.delete),
              ),
            ),
          );
        },
      ),
    );
  }
}

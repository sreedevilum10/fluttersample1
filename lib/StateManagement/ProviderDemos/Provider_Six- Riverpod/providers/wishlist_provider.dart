import 'package:flutter_riverpod/legacy.dart';
import 'package:fluttersample1/StateManagement/ProviderDemos/Provider_Six-%20Riverpod/models/productModel.dart';

class WishlistNotifier extends StateNotifier<List<ProductModel>> {
  WishlistNotifier() : super([]);

  void addToWishlist(ProductModel product) {
    state = [...state, product];
  }

  void removeFromWishlist(ProductModel product) {
    state = state.where((item) => item.id != product.id).toList();
  }
}

final wishlistProvider =
    StateNotifierProvider<WishlistNotifier, List<ProductModel>>((ref) {
      return WishlistNotifier();
    });

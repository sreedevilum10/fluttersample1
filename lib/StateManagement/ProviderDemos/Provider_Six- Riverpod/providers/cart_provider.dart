import 'package:flutter_riverpod/legacy.dart';
import 'package:fluttersample1/StateManagement/ProviderDemos/Provider_Six-%20Riverpod/models/productModel.dart';

class CartNotifier extends StateNotifier<List<ProductModel>> {
  CartNotifier() : super([]);
  void addToCart(ProductModel product) {
    state = [...state, product];// ...state = it copies old items
  }

  void removeFromCart(ProductModel product) {
    state = state
        .where((item) => item.id != product.id)
        .toList();
  }
}
// connect to UI
final cartProvider = StateNotifierProvider<CartNotifier, List<ProductModel>>((ref) {
  return CartNotifier();
});
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:fluttersample1/StateManagement/ProviderDemos/Riverpod_Api_FakeStore/model/ProductModelRiv.dart';
import 'package:fluttersample1/StateManagement/ProviderDemos/Riverpod_Api_FakeStore/service/product_service.dart' show ProductService;


final productServiceProvider = Provider<ProductService>((ref) {
  return ProductService();
});

final productProvider =
FutureProvider<List<ProductModelRivv>>((ref) async {
  return ref.read(productServiceProvider).fetchProducts();
});

class CartNotifier extends StateNotifier<List<ProductModelRivv>> {
  CartNotifier() : super([]);

  void addToCart(ProductModelRivv product) {
    state = [...state, product];
  }
}

final cartProviderFake =
StateNotifierProvider<CartNotifier, List<ProductModelRivv>>((ref) {
  return CartNotifier();
});
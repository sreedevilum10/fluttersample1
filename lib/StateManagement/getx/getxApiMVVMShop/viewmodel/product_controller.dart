// lib/viewmodel/product_controller.dart

import 'package:get/get.dart';
import '../model/product_model.dart';
import '../service/product_service.dart';

class ProductController extends GetxController {
  final _service = ProductService();

  // ── State ──────────────────────────────────────────────────────────────────
  final allProducts   = <Product>[].obs;
  final displayed     = <Product>[].obs;
  final cart          = <Product>[].obs;   // list (allows duplicates = qty)
  final wishlist      = <int>{}.obs;
  final isLoading     = false.obs;
  final errorMsg      = ''.obs;
  final searchQuery   = ''.obs;
  final selectedCat   = 'All'.obs;
  final sortBy        = 'Default'.obs;

  // ── Derived ────────────────────────────────────────────────────────────────
  List<String> get categories {
    final cats = allProducts.map((p) => p.category)
                                      .toSet()
                                      .toList()
                                      ..sort();
    return ['All', ...cats];
  }

  int cartCount(int productId) => cart.where((p) =>
                                       p.id == productId).length;
  int get totalCartItems        => cart.length;
  double get cartTotal          => cart.fold(0, (s, p) =>
                                      s + p.finalPrice);
  bool isWishlisted(int id)     => wishlist.contains(id);

  // ── Lifecycle ──────────────────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    debounce(searchQuery, (_) => _filter(),
                    time: const Duration(
                        milliseconds: 400));
    ever(selectedCat, (_) => _filter());
    ever(sortBy,      (_) => _filter());
    fetchProducts();
  }

  // ── API ────────────────────────────────────────────────────────────────────
  Future<void> fetchProducts() async {
    isLoading.value = true;
    errorMsg.value  = '';
    try {
      allProducts.assignAll(await _service
          .fetchProducts());
      _filter();
    } catch (e) {
      errorMsg.value =
      'Could not load products. '
          'Check your connection.';
    } finally {
      isLoading.value = false;
    }
  }

  // ── Search / Filter / Sort ─────────────────────────────────────────────────
  void onSearch(String q)     => searchQuery.value = q;
  void clearSearch()          => searchQuery.value = '';
  void setCategory(String c)  => selectedCat.value = c;
  void setSort(String s)      => sortBy.value = s;

  void _filter() {
    var list = List<Product>.from(allProducts);

    if (selectedCat.value != 'All') {
      list = list.where((p) =>
          p.category == selectedCat.value)
          .toList();
    }

    final q = searchQuery.value.trim().toLowerCase();
    if (q.isNotEmpty) {
      list = list.where((p) =>
          p.title.toLowerCase().contains(q) ||
          p.brand.toLowerCase().contains(q) ||
          p.category.toLowerCase().contains(q))
           .toList();
    }

    switch (sortBy.value) {
      case 'Price ↑': list.sort((a, b) =>
          a.finalPrice.compareTo(b.finalPrice));
          break;
      case 'Price ↓': list.sort((a, b) =>
          b.finalPrice.compareTo(a.finalPrice));
          break;
      case 'Rating':  list.sort((a, b) =>
          b.rating.compareTo(a.rating));
          break;
    }
    displayed.assignAll(list);
  }

  // ── Cart ───────────────────────────────────────────────────────────────────
  void addToCart(Product p) {
    cart.add(p);
    Get.snackbar('Cart', '${p.title} added',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1));
  }

  void removeOneFromCart(int id) {
    final i = cart.indexWhere((p) => p.id == id);
    if (i != -1) cart.removeAt(i);
  }

  void removeAllFromCart(int id) => cart.removeWhere((p)
      => p.id == id);

  // ── Wishlist ───────────────────────────────────────────────────────────────
  void toggleWishlist(int id) {
    if (wishlist.contains(id)) {
      wishlist.remove(id);
    } else {
      wishlist.add(id);
    }
  }
}

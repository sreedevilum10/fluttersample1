import 'package:flutter/foundation.dart';

/// CartItem is a simple data class for items in the cart.
class CartItem {
  final String id;
  final String name;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
  });
}

/// CartProvider manages the shopping cart state.
/// Demonstrates a provider with multiple methods and computed properties.
class CartProvider extends ChangeNotifier {
  // ── State ──────────────────────────────────────────────────────
  final Map<String, CartItem> _items = {};

  // ── Getters ────────────────────────────────────────────────────
  /// Returns an unmodifiable view of cart items.
  Map<String, CartItem> get items => Map.unmodifiable(_items);

  int get itemCount =>
      _items.values.fold(0, (sum, i) => sum + i.quantity);

  /// Computed total — business logic lives here, not in widgets.
  double get totalPrice =>
      _items.values.fold(0, (sum, i) => sum + i.price * i.quantity);

  bool get isEmpty => _items.isEmpty;

  // ── Methods ────────────────────────────────────────────────────
  void addItem(String id, String name, double price) {
    if (_items.containsKey(id)) {
      _items[id]!.quantity++;
    } else {
      _items[id] = CartItem(id: id, name: name, price: price);
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void decreaseQuantity(String id) {
    if (!_items.containsKey(id)) return;
    if (_items[id]!.quantity <= 1) {
      _items.remove(id);
    } else {
      _items[id]!.quantity--;
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

// ==================== FOOD DELIVERY APP - MVC ARCHITECTURE ====================
// Complete app demonstrating proper MVC pattern for food delivery platform

import 'package:flutter/material.dart';

// ==================== MODELS ====================

class FoodItem {
  final int id;
  final String name;
  final String description;
  final double price;
  final String icon;
  final String category;

  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.icon,
    required this.category,
  });
}

class Restaurant {
  final int id;
  final String name;
  final String cuisine;
  final double rating;
  final int reviews;
  final double distance;
  final int estimatedTime;
  final double deliveryFee;
  final bool isFreeDelivery;
  final String icon;
  final List<FoodItem> menu;

  Restaurant({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.reviews,
    required this.distance,
    required this.estimatedTime,
    required this.deliveryFee,
    required this.isFreeDelivery,
    required this.icon,
    required this.menu,
  });
}

class CartItem {
  final FoodItem foodItem;
  int quantity;
  final int restaurantId;

  CartItem({
    required this.foodItem,
    required this.quantity,
    required this.restaurantId,
  });

  double get totalPrice => foodItem.price * quantity;
}

class DeliveryAddress {
  final String address;
  final String apartment;
  final double latitude;
  final double longitude;

  DeliveryAddress({
    required this.address,
    required this.apartment,
    required this.latitude,
    required this.longitude,
  });
}

class Order {
  final String id;
  final String restaurantName;
  final List<CartItem> items;
  final DeliveryAddress deliveryAddress;
  final String paymentMethod;
  final double subtotal;
  final double tax;
  final double deliveryFee;
  final double total;
  final String status;
  final DateTime orderTime;
  final String driverName;
  final double driverRating;

  Order({
    required this.id,
    required this.restaurantName,
    required this.items,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.subtotal,
    required this.tax,
    required this.deliveryFee,
    required this.total,
    required this.status,
    required this.orderTime,
    required this.driverName,
    required this.driverRating,
  });
}

// ==================== CONTROLLERS ====================

class FoodDeliveryController {
  // Data storage
  List<Restaurant> _restaurants = [];
  List<CartItem> _cartItems = [];
  List<Order> _orders = [];
  DeliveryAddress? _selectedAddress;
  Restaurant? _selectedRestaurant;

  // Getters
  List<Restaurant> get restaurants => _restaurants;
  List<CartItem> get cartItems => _cartItems;
  List<Order> get orders => _orders;
  DeliveryAddress? get selectedAddress => _selectedAddress;
  Restaurant? get selectedRestaurant => _selectedRestaurant;

  // Cart calculations
  double get cartSubtotal =>
      _cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  double get cartTax => cartSubtotal * 0.1;

  double get deliveryFee =>
      _selectedRestaurant?.isFreeDelivery ?? false
          ? 0
          : _selectedRestaurant?.deliveryFee ?? 0;

  double get cartTotal => cartSubtotal + cartTax + deliveryFee;

  int get cartItemCount =>
      _cartItems.fold(0, (sum, item) => sum + item.quantity);

  // Constructor
  FoodDeliveryController() {
    _initializeData();
  }

  void _initializeData() {
    // Initialize food items for Pizza Palace
    final pizzaPalaceMenu = [
      FoodItem(
        id: 1,
        name: 'Margherita Pizza',
        description: 'Fresh tomato, mozzarella & basil',
        price: 12.99,
        icon: '🍕',
        category: 'Pizza',
      ),
      FoodItem(
        id: 2,
        name: 'Pepperoni Pizza',
        description: 'Classic pepperoni with cheese',
        price: 14.99,
        icon: '🍕',
        category: 'Pizza',
      ),
      FoodItem(
        id: 3,
        name: 'Veggie Deluxe',
        description: 'Loaded with vegetables',
        price: 13.99,
        icon: '🍕',
        category: 'Pizza',
      ),
      FoodItem(
        id: 4,
        name: 'Garlic Bread',
        description: 'Crispy garlic bread',
        price: 5.99,
        icon: '🥖',
        category: 'Sides',
      ),
      FoodItem(
        id: 5,
        name: 'Soft Drink',
        description: 'Coca Cola, Sprite, Fanta - 500ml',
        price: 2.99,
        icon: '🥤',
        category: 'Beverages',
      ),
    ];

    // Initialize food items for Burger House
    final burgerHouseMenu = [
      FoodItem(
        id: 6,
        name: 'Classic Burger',
        description: 'Beef patty with cheese & veggies',
        price: 10.99,
        icon: '🍔',
        category: 'Burgers',
      ),
      FoodItem(
        id: 7,
        name: 'Double Burger',
        description: 'Two beef patties with special sauce',
        price: 13.99,
        icon: '🍔',
        category: 'Burgers',
      ),
      FoodItem(
        id: 8,
        name: 'Chicken Sandwich',
        description: 'Crispy chicken with lettuce & mayo',
        price: 9.99,
        icon: '🍗',
        category: 'Sandwiches',
      ),
      FoodItem(
        id: 9,
        name: 'French Fries',
        description: 'Crispy golden fries',
        price: 3.99,
        icon: '🍟',
        category: 'Sides',
      ),
    ];

    // Initialize food items for Noodle Garden
    final noodleGardenMenu = [
      FoodItem(
        id: 10,
        name: 'Pad Thai',
        description: 'Traditional Thai noodles',
        price: 11.99,
        icon: '🍜',
        category: 'Noodles',
      ),
      FoodItem(
        id: 11,
        name: 'Chicken Fried Rice',
        description: 'Fried rice with chicken & eggs',
        price: 10.99,
        icon: '🍚',
        category: 'Rice',
      ),
      FoodItem(
        id: 12,
        name: 'Spring Rolls',
        description: 'Crispy vegetable spring rolls',
        price: 6.99,
        icon: '🥡',
        category: 'Appetizers',
      ),
      FoodItem(
        id: 13,
        name: 'Tom Yum Soup',
        description: 'Spicy Thai soup with shrimp',
        price: 9.99,
        icon: '🍲',
        category: 'Soups',
      ),
    ];

    // Initialize restaurants
    _restaurants = [
      Restaurant(
        id: 1,
        name: 'Pizza Palace',
        cuisine: 'Italian',
        rating: 4.8,
        reviews: 2450,
        distance: 2.3,
        estimatedTime: 30,
        deliveryFee: 0,
        isFreeDelivery: true,
        icon: '🍕',
        menu: pizzaPalaceMenu,
      ),
      Restaurant(
        id: 2,
        name: 'Burger House',
        cuisine: 'American',
        rating: 4.7,
        reviews: 1890,
        distance: 1.8,
        estimatedTime: 25,
        deliveryFee: 2.99,
        isFreeDelivery: false,
        icon: '🍔',
        menu: burgerHouseMenu,
      ),
      Restaurant(
        id: 3,
        name: 'Noodle Garden',
        cuisine: 'Asian',
        rating: 4.9,
        reviews: 3120,
        distance: 3.1,
        estimatedTime: 35,
        deliveryFee: 0,
        isFreeDelivery: true,
        icon: '🍜',
        menu: noodleGardenMenu,
      ),
    ];

    // Initialize default address
    _selectedAddress = DeliveryAddress(
      address: '123 Main Street',
      apartment: 'Apt 4B, Downtown',
      latitude: 40.7128,
      longitude: -74.0060,
    );
  }

  // Restaurant methods
  List<Restaurant> getRestaurants() => _restaurants;

  Restaurant? getRestaurantById(int id) {
    try {
      return _restaurants.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }

  void selectRestaurant(int restaurantId) {
    _selectedRestaurant = getRestaurantById(restaurantId);
    if (_selectedRestaurant != null && _cartItems.isNotEmpty) {
      // Clear cart if switching restaurants
      _cartItems.clear();
    }
  }

  // Cart methods
  void addToCart(FoodItem item) {
    try {
      final existingItem = _cartItems.firstWhere(
            (cartItem) => cartItem.foodItem.id == item.id,
        orElse: () => CartItem(
          foodItem: item,
          quantity: 0,
          restaurantId: _selectedRestaurant?.id ?? 0,
        ),
      );

      if (existingItem.quantity > 0) {
        existingItem.quantity++;
      } else {
        _cartItems.add(CartItem(
          foodItem: item,
          quantity: 1,
          restaurantId: _selectedRestaurant?.id ?? 0,
        ));
      }
    } catch (e) {
      _cartItems.add(CartItem(
        foodItem: item,
        quantity: 1,
        restaurantId: _selectedRestaurant?.id ?? 0,
      ));
    }
  }

  void removeFromCart(int itemId) {
    _cartItems.removeWhere((item) => item.foodItem.id == itemId);
  }

  void updateCartItemQuantity(int itemId, int quantity) {
    try {
      final item = _cartItems.firstWhere((i) => i.foodItem.id == itemId);
      if (quantity <= 0) {
        removeFromCart(itemId);
      } else {
        item.quantity = quantity;
      }
    } catch (e) {
      // Item not found
    }
  }

  void clearCart() {
    _cartItems.clear();
  }

  // Order methods
  bool createOrder({
    required String paymentMethod,
    required String specialInstructions,
  }) {
    try {
      if (_cartItems.isEmpty || _selectedRestaurant == null) {
        return false;
      }

      final order = Order(
        id: 'ORD${DateTime.now().millisecondsSinceEpoch}',
        restaurantName: _selectedRestaurant!.name,
        items: List.from(_cartItems),
        deliveryAddress: _selectedAddress!,
        paymentMethod: paymentMethod,
        subtotal: cartSubtotal,
        tax: cartTax,
        deliveryFee: deliveryFee,
        total: cartTotal,
        status: 'confirmed',
        orderTime: DateTime.now(),
        driverName: 'John Doe',
        driverRating: 4.8,
      );

      _orders.add(order);
      clearCart();
      return true;
    } catch (e) {
      return false;
    }
  }

  List<Order> getOrders() => _orders;

  Order? getOrderById(String orderId) {
    try {
      return _orders.firstWhere((o) => o.id == orderId);
    } catch (e) {
      return null;
    }
  }

  // Address methods
  void setDeliveryAddress(DeliveryAddress address) {
    _selectedAddress = address;
  }
}

// ==================== MAIN APP ====================

void main() {
  runApp(const FoodDeliveryApp());
}

class FoodDeliveryApp extends StatelessWidget {
  const FoodDeliveryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF6B35),
        ),
      ),
      home: FoodDeliveryHome(controller: FoodDeliveryController()),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ==================== MAIN HOME SCREEN ====================

class FoodDeliveryHome extends StatefulWidget {
  final FoodDeliveryController controller;

  const FoodDeliveryHome({Key? key, required this.controller})
      : super(key: key);

  @override
  State<FoodDeliveryHome> createState() => _FoodDeliveryHomeState();
}

class _FoodDeliveryHomeState extends State<FoodDeliveryHome> {
  int _currentIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeView(controller: widget.controller),
      CartView(controller: widget.controller),
      OrdersView(controller: widget.controller),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('🍔 FoodHub'),
        centerTitle: true,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text(widget.controller.cartItemCount.toString()),
              isLabelVisible: widget.controller.cartItemCount > 0,
              child: const Icon(Icons.shopping_cart),
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Orders'),
        ],
      ),
    );
  }
}

// ==================== HOME VIEW ====================

class HomeView extends StatelessWidget {
  final FoodDeliveryController controller;

  const HomeView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            color: const Color(0xFFFF6B35),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fast & Fresh Delivery',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search restaurants...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Promo Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Special Offers',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '50% OFF',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'On first order',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Free Delivery',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'On orders > \$25',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Restaurants Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Featured Restaurants',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.restaurants.length,
            itemBuilder: (context, index) {
              final restaurant = controller.restaurants[index];
              return _buildRestaurantCard(context, restaurant);
            },
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildRestaurantCard(BuildContext context, Restaurant restaurant) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          controller.selectRestaurant(restaurant.id);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  RestaurantMenuScreen(controller: controller),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
                ),
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Center(
                child: Text(restaurant.icon, style: const TextStyle(fontSize: 56)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurant.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${restaurant.cuisine} • ${restaurant.distance} km away',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B35),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${restaurant.rating}⭐',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      if (restaurant.isFreeDelivery)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Free Delivery',
                            style: TextStyle(fontSize: 10),
                          ),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '\$${restaurant.deliveryFee} Delivery',
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '⏱️ ${restaurant.estimatedTime} min',
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== RESTAURANT MENU SCREEN ====================

class RestaurantMenuScreen extends StatelessWidget {
  final FoodDeliveryController controller;

  const RestaurantMenuScreen({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final restaurant = controller.selectedRestaurant;

    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant?.name ?? 'Menu'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant Header
            Container(
              height: 150,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
                ),
              ),
              child: Center(
                child: Text(
                  restaurant?.icon ?? '🍔',
                  style: const TextStyle(fontSize: 64),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant?.name ?? '',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text('${restaurant?.rating}'),
                      const SizedBox(width: 16),
                      const Icon(Icons.location_on, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text('${restaurant?.distance} km away'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Menu Items',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: restaurant?.menu.length ?? 0,
                    itemBuilder: (context, index) {
                      final item = restaurant!.menu[index];
                      return _buildFoodItemCard(context, item);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodItemCard(BuildContext context, FoodItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(item.icon, style: const TextStyle(fontSize: 40)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${item.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF6B35),
                        ),
                      ),
                      FloatingActionButton(
                        mini: true,
                        backgroundColor: const Color(0xFFFF6B35),
                        onPressed: () {
                          controller.addToCart(item);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${item.name} added to cart'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== CART VIEW ====================

class CartView extends StatefulWidget {
  final FoodDeliveryController controller;

  const CartView({Key? key, required this.controller}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return widget.controller.cartItems.isEmpty
        ? _buildEmptyCart()
        : _buildCartContent();
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🛒', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          const Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add items from your favorite restaurants',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Cart Items',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.controller.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = widget.controller.cartItems[index];
                    return _buildCartItemCard(item);
                  },
                ),
                const SizedBox(height: 16),
                _buildPriceBreakdown(),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6B35),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CheckoutScreen(controller: widget.controller),
                        ),
                      );
                    },
                    child: const Text(
                      'Proceed to Checkout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemCard(CartItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Text(item.foodItem.icon, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.foodItem.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${item.foodItem.price.toStringAsFixed(2)} each',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, size: 18),
                  onPressed: () {
                    setState(() {
                      widget.controller.updateCartItemQuantity(
                        item.foodItem.id,
                        item.quantity - 1,
                      );
                    });
                  },
                ),
                Text(
                  '${item.quantity}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add, size: 18),
                  onPressed: () {
                    setState(() {
                      widget.controller.updateCartItemQuantity(
                        item.foodItem.id,
                        item.quantity + 1,
                      );
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              width: 60,
              child: Text(
                '\$${item.totalPrice.toStringAsFixed(2)}',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF6B35),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceBreakdown() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildPriceRow('Subtotal', '\$${widget.controller.cartSubtotal.toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          _buildPriceRow('Delivery Fee', widget.controller.deliveryFee == 0 ? 'FREE' : '\$${widget.controller.deliveryFee.toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          _buildPriceRow('Tax (10%)', '\$${widget.controller.cartTax.toStringAsFixed(2)}'),
          const Divider(height: 16),
          _buildPriceRow(
            'Total',
            '\$${widget.controller.cartTotal.toStringAsFixed(2)}',
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isBold ? const Color(0xFFFF6B35) : Colors.black,
            fontSize: isBold ? 16 : 14,
          ),
        ),
      ],
    );
  }
}

// ==================== CHECKOUT SCREEN ====================

class CheckoutScreen extends StatefulWidget {
  final FoodDeliveryController controller;

  const CheckoutScreen({Key? key, required this.controller}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedPayment = 'card';
  final _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Delivery Address
              _buildSectionTitle('Delivery Address'),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.controller.selectedAddress?.address ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.controller.selectedAddress?.apartment ?? '',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Payment Method
              _buildSectionTitle('Payment Method'),
              _buildPaymentOption('card', 'Credit Card', '****1234'),
              _buildPaymentOption('cash', 'Cash on Delivery', ''),
              _buildPaymentOption('wallet', 'Digital Wallet', ''),
              const SizedBox(height: 24),

              // Special Instructions
              _buildSectionTitle('Special Instructions'),
              TextField(
                controller: _notesController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Add delivery notes...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Order Summary
              _buildOrderSummary(),
              const SizedBox(height: 24),

              // Place Order Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6B35),
                  ),
                  onPressed: () => _placeOrder(),
                  child: const Text(
                    'Place Order',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildPaymentOption(String value, String label, String details) {
    return RadioListTile<String>(
      value: value,
      groupValue: _selectedPayment,
      onChanged: (val) => setState(() => _selectedPayment = val!),
      title: Text(label),
      subtitle: details.isNotEmpty ? Text(details) : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildPriceRow('Subtotal', '\$${widget.controller.cartSubtotal.toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          _buildPriceRow('Delivery', widget.controller.deliveryFee == 0 ? 'FREE' : '\$${widget.controller.deliveryFee.toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          _buildPriceRow('Tax', '\$${widget.controller.cartTax.toStringAsFixed(2)}'),
          const Divider(height: 16),
          _buildPriceRow(
            'Total',
            '\$${widget.controller.cartTotal.toStringAsFixed(2)}',
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isBold ? const Color(0xFFFF6B35) : Colors.black,
            fontSize: isBold ? 16 : 14,
          ),
        ),
      ],
    );
  }

  void _placeOrder() {
    final success = widget.controller.createOrder(
      paymentMethod: _selectedPayment,
      specialInstructions: _notesController.text,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✓ Order placed successfully!'),
          backgroundColor: Color(0xFF4CAF50),
        ),
      );
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error placing order. Try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
}

// ==================== ORDERS VIEW ====================

class OrdersView extends StatelessWidget {
  final FoodDeliveryController controller;

  const OrdersView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = controller.getOrders();

    return orders.isEmpty
        ? _buildNoOrders()
        : _buildOrdersList(context, orders);
  }

  Widget _buildNoOrders() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('📋', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          const Text(
            'No orders yet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Start ordering from your favorite restaurants',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(BuildContext context, List<Order> orders) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      OrderTrackingScreen(order: order),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.restaurantName,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Order #${order.id.substring(3, 10)}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          order.status.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${order.items.length} items',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '\$${order.total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF6B35),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ==================== ORDER TRACKING SCREEN ====================

class OrderTrackingScreen extends StatelessWidget {
  final Order order;

  const OrderTrackingScreen({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Tracking'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Status
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Your order is',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      order.status.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Estimated delivery in 28 minutes',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Timeline
              const Text(
                'Order Timeline',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildTimelineStep('Order Confirmed', '2:30 PM', true),
              _buildTimelineStep('Being Prepared', '2:35 PM', true),
              _buildTimelineStep('On the Way', 'Soon', false),
              _buildTimelineStep('Delivered', 'Pending', false),
              const SizedBox(height: 24),

              // Driver Info
              const Text(
                'Delivery Partner',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFFF6B35), Color(0xFFFF8C42)],
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Text('👨', style: TextStyle(fontSize: 32)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.driverName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '⭐ ${order.driverRating} rating',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.call, color: Color(0xFFFF6B35)),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineStep(String title, String time, bool isCompleted) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isCompleted ? Colors.green : Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Icon(
                  isCompleted ? Icons.check : Icons.schedule,
                  color: isCompleted ? Colors.white : Colors.grey[600],
                  size: 20,
                ),
              ),
            ),
            if (title != 'Delivered')
              Container(
                width: 2,
                height: 40,
                color: isCompleted ? Colors.green : Colors.grey[300],
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isCompleted ? Colors.black : Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
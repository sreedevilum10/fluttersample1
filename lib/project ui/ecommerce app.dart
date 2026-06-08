// ==================== DRESS ECOMMERCE APP - MVC ARCHITECTURE ====================
// Complete app demonstrating professional MVC pattern for fashion ecommerce
// FIXED VERSION - No Overflow Issues

import 'package:flutter/material.dart';

// ==================== MODELS ====================

class Dress {
  final int id;
  final String name;
  final String description;
  final double originalPrice;
  final double salePrice;
  final String icon;
  final String category;
  final double rating;
  final int reviews;
  final List<String> sizes;
  final List<String> colors;
  final String material;
  final String fit;
  final bool isOnSale;
  final bool isNew;

  Dress({
    required this.id,
    required this.name,
    required this.description,
    required this.originalPrice,
    required this.salePrice,
    required this.icon,
    required this.category,
    required this.rating,
    required this.reviews,
    required this.sizes,
    required this.colors,
    required this.material,
    required this.fit,
    required this.isOnSale,
    required this.isNew,
  });

  double get discount =>
      ((originalPrice - salePrice) / originalPrice * 100).round().toDouble();
}

class Category {
  final int id;
  final String name;
  final String icon;
  final Color color;

  Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

class CartItem {
  final Dress dress;
  int quantity;
  final String selectedSize;
  final String selectedColor;

  CartItem({
    required this.dress,
    required this.quantity,
    required this.selectedSize,
    required this.selectedColor,
  });

  double get totalPrice => dress.salePrice * quantity;
}

class Order {
  final String id;
  final List<CartItem> items;
  final String shippingAddress;
  final String paymentMethod;
  final double subtotal;
  final double tax;
  final double shipping;
  final double total;
  final String status;
  final DateTime orderDate;

  Order({
    required this.id,
    required this.items,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.subtotal,
    required this.tax,
    required this.shipping,
    required this.total,
    required this.status,
    required this.orderDate,
  });
}

// ==================== CONTROLLERS ====================

class DressEcommerceController {
  // Data storage
  List<Dress> _dresses = [];
  List<Category> _categories = [];
  List<CartItem> _cartItems = [];
  List<Order> _orders = [];
  List<int> _favorites = [];

  // Getters
  List<Dress> get dresses => _dresses;
  List<Category> get categories => _categories;
  List<CartItem> get cartItems => _cartItems;
  List<Order> get orders => _orders;
  List<int> get favorites => _favorites;

  // Cart calculations
  double get cartSubtotal =>
      _cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  double get cartTax => cartSubtotal * 0.08;

  double get cartShipping => cartSubtotal > 100 ? 0 : 9.99;

  double get cartTotal => cartSubtotal + cartTax + cartShipping;

  int get cartItemCount =>
      _cartItems.fold(0, (sum, item) => sum + item.quantity);

  // Constructor
  DressEcommerceController() {
    _initializeData();
  }

  void _initializeData() {
    // Initialize categories
    _categories = [
      Category(
        id: 1,
        name: 'Casual',
        icon: '👗',
        color: const Color(0xFFF97316),
      ),
      Category(
        id: 2,
        name: 'Formal',
        icon: '✨',
        color: const Color(0xFFEC4899),
      ),
      Category(
        id: 3,
        name: 'Summer',
        icon: '🏖️',
        color: const Color(0xFF8B5CF6),
      ),
      Category(
        id: 4,
        name: 'Winter',
        icon: '❄️',
        color: const Color(0xFF06B6D4),
      ),
    ];

    // Initialize dresses
    _dresses = [
      Dress(
        id: 1,
        name: 'Summer Floral Dress',
        description: 'Premium quality fabric with elegant floral pattern',
        originalPrice: 89.99,
        salePrice: 44.50,
        icon: '👗',
        category: 'Summer',
        rating: 4.8,
        reviews: 245,
        sizes: ['S', 'M', 'L', 'XL'],
        colors: ['Pink', 'Blue', 'Green'],
        material: '100% Cotton',
        fit: 'Relaxed fit',
        isOnSale: true,
        isNew: false,
      ),
      Dress(
        id: 2,
        name: 'Elegant Purple Dress',
        description: 'Sophisticated purple dress perfect for formal events',
        originalPrice: 129.99,
        salePrice: 129.99,
        icon: '👗',
        category: 'Formal',
        rating: 4.9,
        reviews: 312,
        sizes: ['S', 'M', 'L', 'XL'],
        colors: ['Purple', 'Black', 'White'],
        material: 'Silk blend',
        fit: 'Fitted',
        isOnSale: false,
        isNew: true,
      ),
      Dress(
        id: 3,
        name: 'Classic Red Dress',
        description: 'Timeless red dress that works for any occasion',
        originalPrice: 99.99,
        salePrice: 99.99,
        icon: '👗',
        category: 'Casual',
        rating: 4.7,
        reviews: 189,
        sizes: ['XS', 'S', 'M', 'L', 'XL'],
        colors: ['Red', 'Burgundy'],
        material: 'Cotton-Polyester blend',
        fit: 'Regular fit',
        isOnSale: false,
        isNew: false,
      ),
      Dress(
        id: 4,
        name: 'Ocean Blue Dress',
        description: 'Fresh and elegant blue dress for summer wear',
        originalPrice: 119.99,
        salePrice: 83.30,
        icon: '👗',
        category: 'Summer',
        rating: 4.6,
        reviews: 156,
        sizes: ['M', 'L', 'XL'],
        colors: ['Blue', 'Turquoise'],
        material: 'Linen',
        fit: 'Loose fit',
        isOnSale: true,
        isNew: false,
      ),
      Dress(
        id: 5,
        name: 'Black Evening Gown',
        description: 'Luxurious black gown for special occasions',
        originalPrice: 199.99,
        salePrice: 199.99,
        icon: '👗',
        category: 'Formal',
        rating: 4.9,
        reviews: 423,
        sizes: ['S', 'M', 'L', 'XL'],
        colors: ['Black'],
        material: 'Satin',
        fit: 'Fitted',
        isOnSale: false,
        isNew: false,
      ),
      Dress(
        id: 6,
        name: 'Flowy White Dress',
        description: 'Comfortable and stylish white dress',
        originalPrice: 79.99,
        salePrice: 59.99,
        icon: '👗',
        category: 'Casual',
        rating: 4.5,
        reviews: 267,
        sizes: ['XS', 'S', 'M', 'L'],
        colors: ['White', 'Cream'],
        material: 'Cotton',
        fit: 'Loose fit',
        isOnSale: true,
        isNew: false,
      ),
    ];
  }

  // Dress methods
  List<Dress> getDresses() => _dresses;

  List<Dress> getDressesByCategory(String category) {
    return _dresses.where((d) => d.category == category).toList();
  }

  Dress? getDressById(int id) {
    try {
      return _dresses.firstWhere((d) => d.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Dress> searchDresses(String query) {
    return _dresses
        .where(
          (d) =>
      d.name.toLowerCase().contains(query.toLowerCase()) ||
          d.description.toLowerCase().contains(query.toLowerCase()),
    )
        .toList();
  }

  // Category methods
  List<Category> getCategories() => _categories;

  // Cart methods
  void addToCart({
    required Dress dress,
    required String size,
    required String color,
  }) {
    try {
      final existingItem = _cartItems.firstWhere(
            (item) =>
        item.dress.id == dress.id &&
            item.selectedSize == size &&
            item.selectedColor == color,
        orElse: () => CartItem(
          dress: dress,
          quantity: 0,
          selectedSize: size,
          selectedColor: color,
        ),
      );

      if (existingItem.quantity > 0) {
        existingItem.quantity++;
      } else {
        _cartItems.add(
          CartItem(
            dress: dress,
            quantity: 1,
            selectedSize: size,
            selectedColor: color,
          ),
        );
      }
    } catch (e) {
      _cartItems.add(
        CartItem(
          dress: dress,
          quantity: 1,
          selectedSize: size,
          selectedColor: color,
        ),
      );
    }
  }

  void removeFromCart(int index) {
    if (index >= 0 && index < _cartItems.length) {
      _cartItems.removeAt(index);
    }
  }

  void updateCartQuantity(int index, int quantity) {
    if (index >= 0 && index < _cartItems.length) {
      if (quantity <= 0) {
        removeFromCart(index);
      } else {
        _cartItems[index].quantity = quantity;
      }
    }
  }

  void clearCart() {
    _cartItems.clear();
  }

  // Order methods
  bool createOrder({required String address, required String paymentMethod}) {
    try {
      if (_cartItems.isEmpty) {
        return false;
      }

      final order = Order(
        id: 'ORD${DateTime.now().millisecondsSinceEpoch}',
        items: List.from(_cartItems),
        shippingAddress: address,
        paymentMethod: paymentMethod,
        subtotal: cartSubtotal,
        tax: cartTax,
        shipping: cartShipping,
        total: cartTotal,
        status: 'processing',
        orderDate: DateTime.now(),
      );

      _orders.add(order);
      clearCart();
      return true;
    } catch (e) {
      return false;
    }
  }

  List<Order> getOrders() => _orders;

  // Favorite methods
  void toggleFavorite(int dressId) {
    if (_favorites.contains(dressId)) {
      _favorites.remove(dressId);
    } else {
      _favorites.add(dressId);
    }
  }

  bool isFavorite(int dressId) => _favorites.contains(dressId);
}

// ==================== MAIN APP ====================

void main() {
  runApp(const DressEcommerceApp());
}

class DressEcommerceApp extends StatelessWidget {
  const DressEcommerceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fashion Hub',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFEC4899)),
      ),
      home: DressEcommerceHome(controller: DressEcommerceController()),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ==================== MAIN HOME SCREEN ====================

class DressEcommerceHome extends StatefulWidget {
  final DressEcommerceController controller;

  const DressEcommerceHome({Key? key, required this.controller})
      : super(key: key);

  @override
  State<DressEcommerceHome> createState() => _DressEcommerceHomeState();
}

class _DressEcommerceHomeState extends State<DressEcommerceHome> {
  int _currentIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeView(controller: widget.controller),
      BrowseView(controller: widget.controller),
      CartView(controller: widget.controller),
      FavoritesView(controller: widget.controller),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('👗 FashionHub'),
        centerTitle: true,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Browse',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: Text(widget.controller.cartItemCount.toString()),
              isLabelVisible: widget.controller.cartItemCount > 0,
              child: const Icon(Icons.shopping_bag),
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

// ==================== HOME VIEW ====================

class HomeView extends StatelessWidget {
  final DressEcommerceController controller;

  const HomeView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with search
          Container(
            color: const Color(0xFFEC4899),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome to FashionHub',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search dresses...',
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

          // Categories
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    final category = controller.categories[index];
                    return _buildCategoryCard(category);
                  },
                ),
              ],
            ),
          ),

          // Flash Sale Banner
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFEF4444), Color(0xFFF87171)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '⏰ Flash Sale',
                    style: TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '50% OFF',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'on selected items',
                    style: TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Featured Dresses
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Text(
              'Featured Dresses',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              itemCount: controller.dresses.length,
              itemBuilder: (context, index) {
                final dress = controller.dresses[index];
                return _buildDressCard(context, dress);
              },
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Category category) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [category.color, category.color.withOpacity(0.7)],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(category.icon, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              category.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDressCard(BuildContext context, Dress dress) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductDetailsScreen(
                  controller: controller,
                  dress: dress,
                ),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE SECTION
            Stack(
              children: [
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFEC89A),
                        Color(0xFFF8B88B),
                      ],
                    ),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      dress.icon,
                      style: const TextStyle(fontSize: 52),
                    ),
                  ),
                ),

                // SALE / NEW TAG
                Positioned(
                  top: 8,
                  right: 8,
                  child: dress.isOnSale
                      ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '-${dress.discount.toInt()}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                      : dress.isNew
                      ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'NEW',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                      : const SizedBox(),
                ),
              ],
            ),

            // DETAILS SECTION
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // PRODUCT NAME
                    Text(
                      dress.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 4),

                    // RATING
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 12,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 2),

                        Text(
                          '${dress.rating}',
                          style: const TextStyle(fontSize: 10),
                        ),

                        const SizedBox(width: 2),

                        Expanded(
                          child: Text(
                            '(${dress.reviews})',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    // IMPORTANT FIX
                    const Spacer(),

                    // PRICE + FAVORITE
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (dress.isOnSale)
                                Text(
                                  '\$${dress.originalPrice.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                    decoration:
                                    TextDecoration.lineThrough,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),

                              Text(
                                '\$${dress.salePrice.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFEC4899),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            controller.toggleFavorite(dress.id);
                          },
                          child: Icon(
                            controller.isFavorite(dress.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 18,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// ==================== BROWSE VIEW ====================

class BrowseView extends StatelessWidget {
  final DressEcommerceController controller;

  const BrowseView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search dresses...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.dresses.length,
            itemBuilder: (context, index) {
              final dress = controller.dresses[index];
              return _buildDressListItem(context, dress);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDressListItem(BuildContext context, Dress dress) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ProductDetailsScreen(controller: controller, dress: dress),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFEC89A), Color(0xFFF8B88B)],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    dress.icon,
                    style: const TextStyle(fontSize: 48),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dress.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 12, color: Colors.amber),
                        const SizedBox(width: 2),
                        Flexible(
                          child: Text(
                            '${dress.rating}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 11),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            '(${dress.reviews})',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (dress.isOnSale)
                      Flexible(
                        child: RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                '\$${dress.originalPrice.toStringAsFixed(2)} ',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              TextSpan(
                                text:
                                '\$${dress.salePrice.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Color(0xFFEC4899),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      Text(
                        '\$${dress.salePrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEC4899),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== PRODUCT DETAILS SCREEN ====================

class ProductDetailsScreen extends StatefulWidget {
  final DressEcommerceController controller;
  final Dress dress;

  const ProductDetailsScreen({
    Key? key,
    required this.controller,
    required this.dress,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late String _selectedSize;
  late String _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedSize = widget.dress.sizes.first;
    _selectedColor = widget.dress.colors.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              widget.controller.isFavorite(widget.dress.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              setState(() {
                widget.controller.toggleFavorite(widget.dress.id);
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFEC89A), Color(0xFFF8B88B)],
                ),
              ),
              child: Center(
                child: Text(
                  widget.dress.icon,
                  style: const TextStyle(fontSize: 120),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.dress.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '${widget.dress.rating}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '(${widget.dress.reviews} reviews)',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.dress.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Size Selection
                  const Text(
                    'Select Size',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.dress.sizes.map((size) {
                      final isSelected = _selectedSize == size;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedSize = size),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFEC4899)
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            size,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // Color Selection
                  const Text(
                    'Select Color',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: widget.dress.colors.map((color) {
                      final isSelected = _selectedColor == color;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedColor = color),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFEC4899)
                                  : Colors.grey,
                              width: isSelected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            color,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // Price and Add to Cart
                  Row(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Price',
                              style:
                              TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            const SizedBox(height: 4),
                            if (widget.dress.isOnSale)
                              RichText(
                                maxLines: 2,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                      '\$${widget.dress.originalPrice.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        decoration:
                                        TextDecoration.lineThrough,
                                      ),
                                    ),
                                    const TextSpan(text: '\n'),
                                    TextSpan(
                                      text:
                                      '\$${widget.dress.salePrice.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: Color(0xFFEC4899),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            else
                              Text(
                                '\$${widget.dress.salePrice.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFEC4899),
                                ),
                              ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 130,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEC4899),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {
                            widget.controller.addToCart(
                              dress: widget.dress,
                              size: _selectedSize,
                              color: _selectedColor,
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${widget.dress.name} added',
                                ),
                                duration: const Duration(seconds: 1),
                              ),
                            );

                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Details
                  const Text(
                    'Details',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildDetailRow('Material', widget.dress.material),
                  _buildDetailRow('Fit', widget.dress.fit),
                  _buildDetailRow('Care', 'Machine wash cold'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== CART VIEW ====================

class CartView extends StatefulWidget {
  final DressEcommerceController controller;

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
            'Start shopping to add items',
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
                  'Shopping Cart',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.controller.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = widget.controller.cartItems[index];
                    return _buildCartItemCard(index, item);
                  },
                ),
                const SizedBox(height: 16),
                _buildPriceSummary(),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEC4899),
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
                        color: Colors.white,
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

  Widget _buildCartItemCard(int index, CartItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
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
                  colors: [Color(0xFFFEC89A), Color(0xFFF8B88B)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  item.dress.icon,
                  style: const TextStyle(fontSize: 40),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.dress.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Size: ${item.selectedSize} | ${item.selectedColor}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          '\$${item.dress.salePrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFEC4899),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 28,
                            height: 28,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.remove, size: 16),
                              onPressed: () {
                                setState(() {
                                  widget.controller.updateCartQuantity(
                                    index,
                                    item.quantity - 1,
                                  );
                                });
                              },
                            ),
                          ),
                          Text('${item.quantity}'),
                          SizedBox(
                            width: 28,
                            height: 28,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.add, size: 16),
                              onPressed: () {
                                setState(() {
                                  widget.controller.updateCartQuantity(
                                    index,
                                    item.quantity + 1,
                                  );
                                });
                              },
                            ),
                          ),
                        ],
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

  Widget _buildPriceSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildPriceRow(
            'Subtotal',
            '\$${widget.controller.cartSubtotal.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 8),
          _buildPriceRow(
            'Shipping',
            widget.controller.cartShipping == 0
                ? 'FREE'
                : '\$${widget.controller.cartShipping.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 8),
          _buildPriceRow(
            'Tax',
            '\$${widget.controller.cartTax.toStringAsFixed(2)}',
          ),
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
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? const Color(0xFFEC4899) : Colors.black,
              fontSize: isBold ? 16 : 14,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

// ==================== CHECKOUT SCREEN ====================

class CheckoutScreen extends StatefulWidget {
  final DressEcommerceController controller;

  const CheckoutScreen({Key? key, required this.controller}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _addressController = TextEditingController();
  String _selectedPayment = 'card';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout'), elevation: 0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Shipping Address',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  hintText: 'Enter your address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                minLines: 3,
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              const Text(
                'Payment Method',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildPaymentOption('card', 'Credit Card', '****1234'),
              _buildPaymentOption('paypal', 'PayPal', ''),
              _buildPaymentOption('apple', 'Apple Pay', ''),
              const SizedBox(height: 24),

              const Text(
                'Order Summary',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              _buildOrderSummary(),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEC4899),
                  ),
                  onPressed: _placeOrder,
                  child: const Text(
                    'Place Order',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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

  Widget _buildPaymentOption(String value, String label, String details) {
    return RadioListTile<String>(
      value: value,
      groupValue: _selectedPayment,
      onChanged: (val) => setState(() => _selectedPayment = val!),
      title: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: details.isNotEmpty
          ? Text(details, maxLines: 1, overflow: TextOverflow.ellipsis)
          : null,
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
        children: [
          _buildSummaryRow(
            'Subtotal',
            '\$${widget.controller.cartSubtotal.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 8),
          _buildSummaryRow(
            'Shipping',
            widget.controller.cartShipping == 0
                ? 'FREE'
                : '\$${widget.controller.cartShipping.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 8),
          _buildSummaryRow(
            'Tax',
            '\$${widget.controller.cartTax.toStringAsFixed(2)}',
          ),
          const Divider(height: 16),
          _buildSummaryRow(
            'Total',
            '\$${widget.controller.cartTotal.toStringAsFixed(2)}',
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? const Color(0xFFEC4899) : Colors.black,
              fontSize: isBold ? 16 : 14,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  void _placeOrder() {
    if (_addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter address')),
      );
      return;
    }

    final success = widget.controller.createOrder(
      address: _addressController.text,
      paymentMethod: _selectedPayment,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✓ Order placed!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }
}

// ==================== FAVORITES VIEW ====================

class FavoritesView extends StatelessWidget {
  final DressEcommerceController controller;

  const FavoritesView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favorites = controller.dresses
        .where((d) => controller.favorites.contains(d.id))
        .toList();

    return favorites.isEmpty
        ? Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('❤️', style: TextStyle(fontSize: 64)),
          const SizedBox(height: 16),
          const Text(
            'No favorites yet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add dresses to favorites',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    )
        : Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final dress = favorites[index];
          return _buildFavoriteDressCard(context, dress);
        },
      ),
    );
  }

  Widget _buildFavoriteDressCard(BuildContext context, Dress dress) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFEC89A), Color(0xFFF8B88B)],
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Center(
              child: Text(dress.icon, style: const TextStyle(fontSize: 56)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      dress.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '\$${dress.salePrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFEC4899),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
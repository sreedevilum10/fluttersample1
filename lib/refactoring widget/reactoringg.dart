import 'package:flutter/material.dart';

void main() {
  runApp(const ProductPageApp());
}

class ProductPageApp extends StatelessWidget {
  const ProductPageApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Catalog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ProductPage(),
    );
  }
}

// ==================== PRODUCT MODEL ====================

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final double originalPrice;
  final double rating;
  final int reviews;
  final String image;
  final String category;
  final bool inStock;
  final int discount;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.rating,
    required this.reviews,
    required this.image,
    required this.category,
    required this.inStock,
    required this.discount,
  });
}

// ==================== PRODUCT PAGE WITH REFRESHINDICATOR ====================

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // Products list
  List<Product> products = [];

  // Loading and error states
  bool isLoading = false;
  String? errorMessage;

  // Filter and sort
  String selectedCategory = 'All';
  String sortBy = 'Popular';

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  // ==================== LOAD PRODUCTS ====================

  Future<void> _loadProducts() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Create sample products
      products = [
        Product(
          id: 1,
          name: 'Premium Wireless Headphones',
          description: 'High-quality sound with noise cancellation',
          price: 89.99,
          originalPrice: 129.99,
          rating: 4.8,
          reviews: 342,
          image: '🎧',
          category: 'Electronics',
          inStock: true,
          discount: 30,
        ),
        Product(
          id: 2,
          name: 'Smart Watch',
          description: 'Track fitness and receive notifications',
          price: 199.99,
          originalPrice: 299.99,
          rating: 4.6,
          reviews: 218,
          image: '⌚',
          category: 'Electronics',
          inStock: true,
          discount: 33,
        ),
        Product(
          id: 3,
          name: 'Leather Backpack',
          description: 'Durable and stylish leather backpack',
          price: 59.99,
          originalPrice: 89.99,
          rating: 4.7,
          reviews: 156,
          image: '🎒',
          category: 'Fashion',
          inStock: true,
          discount: 33,
        ),
        Product(
          id: 4,
          name: 'Coffee Maker',
          description: 'Automatic brew with timer and filter',
          price: 79.99,
          originalPrice: 119.99,
          rating: 4.5,
          reviews: 289,
          image: '☕',
          category: 'Home',
          inStock: true,
          discount: 33,
        ),
        Product(
          id: 5,
          name: 'Running Shoes',
          description: 'Comfortable for marathon training',
          price: 119.99,
          originalPrice: 159.99,
          rating: 4.9,
          reviews: 423,
          image: '👟',
          category: 'Fashion',
          inStock: true,
          discount: 25,
        ),
        Product(
          id: 6,
          name: 'USB-C Cable',
          description: 'Fast charging and data transfer',
          price: 12.99,
          originalPrice: 19.99,
          rating: 4.4,
          reviews: 567,
          image: '🔌',
          category: 'Electronics',
          inStock: true,
          discount: 35,
        ),
        Product(
          id: 7,
          name: 'Water Bottle',
          description: 'Stainless steel, keeps water cold for 24hrs',
          price: 34.99,
          originalPrice: 49.99,
          rating: 4.7,
          reviews: 178,
          image: '🧴',
          category: 'Sports',
          inStock: true,
          discount: 30,
        ),
        Product(
          id: 8,
          name: 'Desk Lamp',
          description: 'LED lamp with adjustable brightness',
          price: 44.99,
          originalPrice: 69.99,
          rating: 4.6,
          reviews: 134,
          image: '💡',
          category: 'Home',
          inStock: true,
          discount: 35,
        ),
        Product(
          id: 9,
          name: 'Yoga Mat',
          description: 'Non-slip, eco-friendly material',
          price: 29.99,
          originalPrice: 49.99,
          rating: 4.8,
          reviews: 245,
          image: '🧘',
          category: 'Sports',
          inStock: false,
          discount: 40,
        ),
        Product(
          id: 10,
          name: 'Camera Tripod',
          description: 'Lightweight aluminum tripod',
          price: 39.99,
          originalPrice: 59.99,
          rating: 4.5,
          reviews: 89,
          image: '📷',
          category: 'Electronics',
          inStock: true,
          discount: 33,
        ),
      ];

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error loading products: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  // ==================== REFRESH PRODUCTS (PULL TO REFRESH) ====================

  Future<void> _refreshProducts() async {
    try {
      // Simulate network request
      await Future.delayed(const Duration(seconds: 2));

      // In real app, fetch from API with filters
      // For demo, we'll add a new product to the list
      List<Product> newProducts = [
        Product(
          id: DateTime.now().millisecondsSinceEpoch,
          name: 'New Product',
          description: 'Just added to catalog',
          price: 99.99,
          originalPrice: 149.99,
          rating: 4.5,
          reviews: 0,
          image: '✨',
          category: selectedCategory == 'All' ? 'Electronics' : selectedCategory,
          inStock: true,
          discount: 33,
        ),
      ];

      setState(() {
        // Add new products at the beginning
        products = [...newProducts, ...products];
      });

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Products refreshed successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Handle error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error refreshing products: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // ==================== GET FILTERED PRODUCTS ====================

  List<Product> get filteredProducts {
    if (selectedCategory == 'All') {
      return products;
    }
    return products
        .where((product) => product.category == selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Catalog'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cart opened')),
              );
            },
          ),
        ],
      ),
      body: isLoading && products.isEmpty
          ? _buildLoadingState()
          : errorMessage != null
          ? _buildErrorState()
          : _buildProductList(),
    );
  }

  // ==================== BUILD PRODUCT LIST WITH REFRESHINDICATOR ====================

  Widget _buildProductList() {
    return Column(
      children: [
        // Category Filter
        _buildCategoryFilter(),

        // Products with RefreshIndicator
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refreshProducts,
            color: Colors.blueAccent,
            backgroundColor: Colors.white,
            strokeWidth: 3,
            displacement: 40,
            child: filteredProducts.isEmpty
                ? _buildEmptyState()
                : GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: filteredProducts[index],
                  onTap: () {
                    _showProductDetails(filteredProducts[index]);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  // ==================== BUILD CATEGORY FILTER ====================

  Widget _buildCategoryFilter() {
    final categories = ['All', 'Electronics', 'Fashion', 'Home', 'Sports'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: categories.map((category) {
            final isSelected = selectedCategory == category;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(category),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    selectedCategory = category;
                  });
                },
                backgroundColor: Colors.grey[200],
                selectedColor: Colors.blueAccent,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ==================== BUILD LOADING STATE ====================

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
          ),
          const SizedBox(height: 16),
          const Text(
            'Loading products...',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // ==================== BUILD ERROR STATE ====================

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            errorMessage ?? 'An error occurred',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.red),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _loadProducts,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  // ==================== BUILD EMPTY STATE ====================

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 64,
            color: Colors.grey.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'No products in this category',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          const Text(
            'Pull down to refresh',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // ==================== SHOW PRODUCT DETAILS ====================

  void _showProductDetails(Product product) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ProductDetailsSheet(product: product),
    );
  }
}

// ==================== PRODUCT CARD WIDGET ====================

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Section
            Expanded(
              child: Stack(
                children: [
                  // Image Container
                  Container(
                    width: double.infinity,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      color: Colors.blueAccent.withOpacity(0.1),
                    ),
                    child: Center(
                      child: Text(
                        widget.product.image,
                        style: const TextStyle(fontSize: 48),
                      ),
                    ),
                  ),
              
                  // Discount Badge
                  if (widget.product.discount > 0)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '-${widget.product.discount}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
              
                  // Favorite Button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
              
                  // Stock Status
                  if (!widget.product.inStock)
                    Container(
                      width: double.infinity,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        color: Colors.black.withOpacity(0.4),
                      ),
                      child: const Center(
                        child: Text(
                          'Out of Stock',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Product Info Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    Text(
                      widget.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Rating
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 2),
                        Text(
                          '${widget.product.rating}',
                          style: const TextStyle(fontSize: 11),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${widget.product.reviews})',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),

                    // Price Section
                    Expanded(
                      child: Row(
                        children: [
                          // Current Price
                          Text(
                            '\$${widget.product.price}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          const SizedBox(width: 4),
                          // Original Price (strikethrough)
                          Text(
                            '\$${widget.product.originalPrice}',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Add to Cart Button
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              child: ElevatedButton.icon(
                onPressed: widget.product.inStock
                    ? () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                      Text('${widget.product.name} added to cart'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                }
                    : null,
                icon: const Icon(Icons.shopping_cart, size: 16),
                label: const Text('Add', style: TextStyle(fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  disabledBackgroundColor: Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== PRODUCT DETAILS SHEET ====================

class ProductDetailsSheet extends StatelessWidget {
  final Product product;

  const ProductDetailsSheet({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close Button
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ),

            // Product Image
            Center(
              child: Text(
                product.image,
                style: const TextStyle(fontSize: 80),
              ),
            ),
            const SizedBox(height: 16),

            // Product Name
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Category
            Chip(
              label: Text(product.category),
              backgroundColor: Colors.blueAccent.withOpacity(0.2),
            ),
            const SizedBox(height: 16),

            // Rating
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  '${product.rating}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '(${product.reviews} reviews)',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Price
            Row(
              children: [
                Text(
                  '\$${product.price}',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '\$${product.originalPrice}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Save ${product.discount}% off!',
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Description
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),

            // Stock Status
            Row(
              children: [
                const Icon(
                  Icons.inventory,
                  color: Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  product.inStock ? 'In Stock' : 'Out of Stock',
                  style: TextStyle(
                    fontSize: 14,
                    color:
                    product.inStock ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Add to Cart Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: product.inStock
                    ? () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} added to cart!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context);
                }
                    : null,
                icon: const Icon(Icons.shopping_cart),
                label: const Text('Add to Cart'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  disabledBackgroundColor: Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
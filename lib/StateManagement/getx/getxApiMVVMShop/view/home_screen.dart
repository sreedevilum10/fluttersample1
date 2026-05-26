// lib/view/home_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../viewmodel/product_controller.dart';
import 'cart_screen.dart';
import 'detail_screen.dart';
import 'widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProductController>();

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade800,
        title: const Text(
          'ShopX',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          // ── Cart icon with badge ───────────────────────────────────────
          Obx(
            () => Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () => Get.to(() => const CartScreen()),
                ),
                if (c.totalCartItems > 0)
                  Positioned(
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${c.totalCartItems}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // ── Search bar ───────────────────────────────────────────────────
          _SearchBar(ctrl: _searchCtrl),
          // ── Category chips ───────────────────────────────────────────────
          _CategoryBar(),
          // ── Sort + count ─────────────────────────────────────────────────
          _SortRow(),
          // ── Product grid ─────────────────────────────────────────────────
          Expanded(child: _ProductGrid()),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Search bar — uses setState for clear button, NOT Obx inside InputDecoration
// ─────────────────────────────────────────────────────────────────────────────
class _SearchBar extends StatefulWidget {
  final TextEditingController ctrl;

  const _SearchBar({required this.ctrl});

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  bool _hasText = false;

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProductController>();
    return Container(
      color: Colors.deepPurple.shade800,
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: TextField(
        controller: widget.ctrl,
        style: const TextStyle(color: Colors.white),
        onChanged: (val) {
          c.onSearch(val);
          setState(() => _hasText = val.isNotEmpty);
        },
        decoration: InputDecoration(
          hintText: 'Search products…',
          hintStyle: const TextStyle(color: Colors.white60),
          prefixIcon: const Icon(Icons.search, color: Colors.white70),
          suffixIcon: _hasText
              ? IconButton(
                  icon: const Icon(Icons.close, color: Colors.white70),
                  onPressed: () {
                    widget.ctrl.clear();
                    c.clearSearch();
                    setState(() => _hasText = false);
                  },
                )
              : null,
          filled: true,
          fillColor: Colors.white24,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Category bar
// ─────────────────────────────────────────────────────────────────────────────
class _CategoryBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProductController>();
    return Obx(() {
      if (c.isLoading.value) {
        return const SizedBox.shrink();
      }
      return Container(
        color: Colors.white,
        height: 46,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          itemCount: c.categories.length,
          itemBuilder: (context, i) {
            final cat = c.categories[i];
            final selected = c.selectedCat.value == cat;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => c.setCategory(cat),
                child: AnimatedContainer(
                  duration: const Duration(
                      milliseconds: 180),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14),
                  decoration: BoxDecoration(
                    color: selected ? Colors.deepPurple
                        : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      cat[0].toUpperCase()
                          + cat.substring(1),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: selected ? Colors.white
                            : Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sort row
// ─────────────────────────────────────────────────────────────────────────────
class _SortRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProductController>();
    return Obx(() {
      if (c.isLoading.value
          || c.allProducts.isEmpty) {
        return const SizedBox.shrink();
      }
      return Padding(
        padding: const EdgeInsets
            .fromLTRB(14, 8, 14, 2),
        child: Row(
          children: [
            Text(
              '${c.displayed.length} products',
              style: TextStyle(fontSize: 12,
                  color: Colors.grey.shade600),
            ),
            const Spacer(),
            // Sort popup — NO Obx wrapper (itemBuilder is lazy, not tracked)
            PopupMenuButton<String>(
              onSelected: c.setSort,
              child: Row(
                children: [
                  Icon(Icons.sort, size: 16,
                      color: Colors.deepPurple.shade600),
                  const SizedBox(width: 4),
                  Text(
                    'Sort: ${c.sortBy.value}',
                    style: TextStyle(
                      fontSize: 12,
                      color:
                      Colors.deepPurple.shade600,
                    ),
                  ),
                ],
              ),
              itemBuilder: (_) => [
                'Default',
                'Price ↑',
                'Price ↓',
                'Rating',
              ].map((option) =>
                  PopupMenuItem(
                      value: option,
                      child: Text(option)))
                  .toList(),
            ),
          ],
        ),
      );
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Product grid
// ─────────────────────────────────────────────────────────────────────────────
class _ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProductController>();
    return Obx(() {
      if (c.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(
              color: Colors.deepPurple),
        );
      }
      if (c.errorMsg.value.isNotEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off_rounded,
                  size: 56, color: Colors.grey),
              const SizedBox(height: 12),
              Text(
                c.errorMsg.value,
                style: const TextStyle(
                    color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: c.fetchProducts,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      }
      if (c.displayed.isEmpty) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.search_off_rounded,
                size: 56,
                color: Colors.grey,
              ),
              const SizedBox(height: 10),
              const Text(
                'No products found',
                style: TextStyle(color: Colors.grey),
              ),
              TextButton(
                onPressed: c.clearSearch,
                child: const Text('Clear search'),
              ),
            ],
          ),
        );
      }
      return RefreshIndicator(
        onRefresh: c.fetchProducts,
        color: Colors.deepPurple,
        child: GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.72,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: c.displayed.length,
          itemBuilder: (_, i) => _ProductCard(product: c.displayed[i]),
        ),
      );
    });
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Product card
// ─────────────────────────────────────────────────────────────────────────────
class _ProductCard extends StatelessWidget {
  final dynamic product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProductController>();
    final p = product;

    return GestureDetector(
      onTap: () => Get.to(() => DetailScreen(product: p)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image ──────────────────────────────────────────────────────
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(14),
                  ),
                  child: ProductImage(url: p.thumbnail, height: 130),
                ),
                // Discount badge
                if (p.discountPercentage >= 5)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.shade600,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '-${p.discountPercentage.toStringAsFixed(0)}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                // Wishlist button
                Positioned(
                  top: 4,
                  right: 4,
                  child: Obx(
                    () => GestureDetector(
                      onTap: () => c.toggleWishlist(p.id),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          c.isWishlisted(p.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 16,
                          color: c.isWishlisted(p.id)
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ── Info ───────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1A1A2E),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  RatingStars(rating: p.rating, reviewCount: p.reviews.length),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Text(
                        '\$${p.finalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      if (p.discountPercentage > 0) ...[
                        const SizedBox(width: 4),
                        Text(
                          '\$${p.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade500,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Add to cart button
                  Obx(() {
                    final qty = c.cartCount(p.id);
                    return qty == 0
                        ? SizedBox(
                            width: double.infinity,
                            height: 34,
                            child: ElevatedButton(
                              onPressed: () => c.addToCart(p),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                'Add',
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          )
                        : Row(
                            children: [
                              _QtyBtn(
                                icon: Icons.remove,
                                onTap: () => c.removeOneFromCart(p.id),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    '$qty',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ),
                              ),
                              _QtyBtn(
                                icon: Icons.add,
                                onTap: () => c.addToCart(p),
                              ),
                            ],
                          );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QtyBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon, size: 14, color: Colors.deepPurple),
    ),
  );
}

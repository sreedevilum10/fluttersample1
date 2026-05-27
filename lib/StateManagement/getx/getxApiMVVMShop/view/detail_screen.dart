// lib/view/detail_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/product_model.dart';
import '../viewmodel/product_controller.dart';
import 'widgets.dart';

class DetailScreen extends StatefulWidget {
  final Product product;
  const DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _imgIndex = 0;

  Product get p => widget.product;

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ProductController>();
    final imgs = p.images.isNotEmpty
        ? p.images
        : [p.thumbnail];
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade800,
        foregroundColor: Colors.white,
        title: Text(p.title,
            style: const TextStyle(fontSize: 15),
            overflow: TextOverflow.ellipsis),
        actions: [
          Obx(() => IconButton(
                icon: Icon(c.isWishlisted(p.id)
                    ? Icons.favorite
                    : Icons.favorite_border,
                  color: c.isWishlisted(p.id)
                      ? Colors.red.shade300
                      : Colors.white,
                ),
                onPressed: () =>
                    c.toggleWishlist(p.id),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image gallery ───────────────────────────────────────────────
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  // Main image
                  SizedBox(
                    height: 260,
                    width: double.infinity,
                    child: ProductImage(
                        url: imgs[_imgIndex],
                        height: 260,
                        fit: BoxFit.contain),
                  ),
                  // Thumbnail strip
                  if (imgs.length > 1)
                    SizedBox(
                      height: 60,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(8),
                        itemCount: imgs.length,
                        itemBuilder: (_, i) => GestureDetector(
                          onTap: () => setState(() => _imgIndex = i),
                          child: Container(
                            width: 48,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: i == _imgIndex
                                    ? Colors.deepPurple
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: ProductImage(
                                  url: imgs[i], height: 44),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Category + brand ──────────────────────────────────────
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade50,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(p.category,
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.deepPurple.shade700,
                                fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(width: 8),
                      Text('by ${p.brand}',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // ── Title ─────────────────────────────────────────────────
                  Text(p.title,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),

                  // ── Rating + stock ────────────────────────────────────────
                  Row(
                    children: [
                      RatingStars(
                          rating: p.rating,
                          reviewCount: p.reviews.length),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: p.isLowStock
                              ? Colors.orange.shade50
                              : Colors.green.shade50,
                          borderRadius: BorderRadius
                              .circular(6),
                        ),
                        child: Text(
                          p.isLowStock
                              ? 'Only ${p.stock} left!'
                              : 'In Stock',
                          style: TextStyle(
                              fontSize: 11,
                              color: p.isLowStock
                                  ? Colors.orange.shade800
                                  : Colors.green.shade700,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // ── Price ─────────────────────────────────────────────────
                  Row(
                    children: [
                      Text('\$${p.finalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple)),
                      if (p.discountPercentage > 0) ...[
                        const SizedBox(width: 10),
                        Text('\$${p.price.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade500,
                                decoration: TextDecoration.lineThrough)),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(6)),
                          child: Text(
                              '${p.discountPercentage.toStringAsFixed(0)}% OFF',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.red.shade700,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16),

                  // ── Info rows ─────────────────────────────────────────────
                  _infoRow(Icons.local_shipping_outlined, 'Shipping',
                      p.shippingInformation),
                  _infoRow(Icons.assignment_return_outlined, 'Returns',
                      p.returnPolicy),
                  const SizedBox(height: 14),

                  // ── Description ───────────────────────────────────────────
                  const Text('Description',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(p.description,
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                          height: 1.55)),
                  const SizedBox(height: 16),

                  // ── Reviews ───────────────────────────────────────────────
                  if (p.reviews.isNotEmpty) ...[
                    const Text('Reviews',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...p.reviews.map((r) => _ReviewTile(review: r)),
                  ],
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),

      // ── Bottom bar: Add to cart ───────────────────────────────────────────
      bottomNavigationBar: Obx(() {
        final c = Get.find<ProductController>();
        final qty = c.cartCount(p.id);
        return Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 10,
                  offset: const Offset(0, -2))
            ],
          ),
          child: Row(
            children: [
              if (qty > 0) ...[
                // Qty controls
                _QtyButton(
                    icon: Icons.remove,
                    onTap: () => c.removeOneFromCart(p.id)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text('$qty',
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple)),
                ),
                _QtyButton(
                    icon: Icons.add, onTap: () => c.addToCart(p)),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => c.addToCart(p),
                  icon: const Icon(Icons.add_shopping_cart, size: 18),
                  label: Text(qty == 0 ? 'Add to Cart' : 'Add One More'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Icon(icon, size: 16, color: Colors.deepPurple.shade400),
            const SizedBox(width: 8),
            Text('$label: ',
                style: const TextStyle(
                    fontSize: 12, color: Colors.grey)),
            Expanded(
              child: Text(value,
                  style: const TextStyle(fontSize: 12),
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      );
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, size: 18, color: Colors.deepPurple),
        ),
      );
}

class _ReviewTile extends StatelessWidget {
  final Review review;
  const _ReviewTile({required this.review});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.deepPurple.shade100,
                  child: Text(review.reviewerName[0],
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.deepPurple.shade800,
                          fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 8),
                Text(review.reviewerName,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w600)),
                const Spacer(),
                RatingStars(rating: review.rating.toDouble()),
              ],
            ),
            const SizedBox(height: 6),
            Text(review.comment,
                style: const TextStyle(fontSize: 12, color: Colors.black87)),
          ],
        ),
      );
}

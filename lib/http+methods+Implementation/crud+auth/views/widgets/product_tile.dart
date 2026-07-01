// lib/views/widgets/product_tile.dart
// ============================================================================
// PRODUCT TILE WIDGET
// ============================================================================
// A reusable widget that displays a single product in a list.
// Shows product information and action buttons.
// ============================================================================

import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductTile extends StatelessWidget {
  // ========================================================================
  // PROPERTIES
  // ========================================================================
  // The product data to display
  final Product product;

  // Callback when edit button is pressed
  final VoidCallback onEdit;

  // Callback when delete button is pressed
  final VoidCallback onDelete;

  // ========================================================================
  // CONSTRUCTOR
  // ========================================================================
  const ProductTile({
    Key? key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  // ========================================================================
  // BUILD METHOD
  // ========================================================================
  @override
  Widget build(BuildContext context) {
    // Parse price as double for formatting
    double price = double.tryParse(product.price) ?? 0;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================================================================
            // HEADER ROW - Product Name and Price
            // ================================================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Product name with category
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product name
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Category badge (if available)
                      if (product.category != null && product.category!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              product.category!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // Price display
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '₹${price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ================================================================
            // DESCRIPTION (if available)
            // ================================================================
            if (product.description != null && product.description!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  product.description!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

            // ================================================================
            // STOCK AND ACTION BUTTONS ROW
            // ================================================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Stock information
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _getStockColor().shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.inventory_2,
                        size: 16,
                        color: _getStockColor().shade700,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Stock: ${product.stock}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: _getStockColor().shade700,
                        ),
                      ),
                    ],
                  ),
                ),

                // Action buttons
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Edit button
                    Tooltip(
                      message: 'Edit product',
                      child: IconButton(
                        onPressed: onEdit,
                        icon: const Icon(Icons.edit),
                        color: Colors.blue,
                        iconSize: 20,
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Delete button
                    Tooltip(
                      message: 'Delete product',
                      child: IconButton(
                        onPressed: onDelete,
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        iconSize: 20,
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(
                          minWidth: 40,
                          minHeight: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ========================================================================
  // HELPER METHODS
  // ========================================================================

  /// Determines the color for stock display based on quantity
  /// Green: Good stock (> 10)
  /// Orange: Medium stock (1-10)
  /// Red: Low stock (0)
  MaterialColor _getStockColor() {
    if (product.stock > 10) {
      return Colors.green;
    } else if (product.stock > 0) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}

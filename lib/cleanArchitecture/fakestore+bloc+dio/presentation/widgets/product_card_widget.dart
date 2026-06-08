// Import Flutter material design
import 'package:flutter/material.dart';
// Import Product entity
import '../../domain/entities/product.dart';

// ============== PRODUCT CARD WIDGET ==============
// StatelessWidget = doesn't manage state
// Receives product as parameter, displays it
class ProductCardWidget extends StatelessWidget {
  // ============== PROPERTIES ==============
  // Store the product to display
  final Product product;

  // Constructor: requires product
  const ProductCardWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Return Card widget (material design)
    return Card(
      // elevation = shadow effect
      elevation: 4,
      
      // Margin = space around card
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      
      child: Column(
        // Arrange items vertically
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          // ============== IMAGE SECTION ==============
          // Container for product image
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey[200],
            
            // Image widget to display product image
            child: Image.network(
              product.image,
              fit: BoxFit.contain,
              
              // What to show if image fails to load
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 50,
                    color: Colors.grey[400],
                  ),
                );
              },
            ),
          ),

          // ============== PRODUCT DETAILS SECTION ==============
          Padding(
            padding: const EdgeInsets.all(12),
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                // ============== TITLE ==============
                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 8),

                // ============== RATING ==============
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      '${product.rating} (${product.ratingCount})',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 8),

                // ============== CATEGORY BADGE ==============
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  
                  child: Text(
                    product.category.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                ),
                
                const SizedBox(height: 12),

                // ============== PRICE AND BUTTON ==============
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  
                  children: [
                    // ============== PRICE ==============
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    
                    // ============== ADD TO CART BUTTON ==============
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.title} added to cart'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      
                      icon: const Icon(Icons.shopping_cart, size: 16),
                      label: const Text('Add'),
                      
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

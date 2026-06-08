// Import Equatable for comparing Product objects
import 'package:equatable/equatable.dart';

// ============== PRODUCT ENTITY ==============
// Entity = pure data class representing a product
// Extends Equatable to compare products by value, not reference
class Product extends Equatable {
  // ============== PROPERTIES ==============
  // unique identifier from FakeStore API
  // final = cannot be changed after creation
  final int id;
  // product name/title from API
  final String title;
  // product price in dollars
  // double = decimal number (e.g., 19.99)
  final double price;
  // long text describing the product
  final String description;
  // product category (electronics, clothing, etc.)
  final String category;
  // URL to product image
  final String image;
  // star rating (1-5 stars)
  final double rating;
  // how many people rated this product
  final int ratingCount;

  // ============== CONSTRUCTOR ==============
  // Initializes Product with all required information
  // const = can be used at compile time (more efficient)
  // required = all parameters must be provided
  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.ratingCount,
  });

  // ============== EQUATABLE OVERRIDE ==============
  // props = properties to check when comparing
  // When comparing two Products, all these properties are checked
  @override
  List<Object?> get props => [
    id,
    title,
    price,
    description,
    category,
    image,
    rating,
    ratingCount,
  ];
}

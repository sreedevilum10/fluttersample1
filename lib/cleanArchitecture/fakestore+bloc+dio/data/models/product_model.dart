// Import Product entity
import '../../domain/entities/product.dart';

// ============== PRODUCT MODEL ==============
// Model = data class that works with API and database
// Extends Product entity to add conversion methods
class ProductModel extends Product {
  // Inherits all properties from Product
  // Constructor
  const ProductModel({
    required int id,
    required String title,
    required double price,
    required String description,
    required String category,
    required String image,
    required double rating,
    required int ratingCount,
  }) : super(
    id: id,
    title: title,
    price: price,
    description: description,
    category: category,
    image: image,
    rating: rating,
    ratingCount: ratingCount,
  );

  // ============== JSON TO MODEL CONVERSION ==============
  // Converts JSON from API response to ProductModel object
  // This is called: ProductModel.fromJson(jsonData)
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // json = Map received from API
    return ProductModel(
      // Extract and cast each field from JSON
      id: json['id'] as int,
      title: json['title'] as String,
      // Cast to num first, then convert to double
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      category: json['category'] as String,
      image: json['image'] as String,
      // Access nested rating.rate
      rating: (json['rating']['rate'] as num).toDouble(),
      // Access nested rating.count
      ratingCount: json['rating']['count'] as int,
    );
  }

  // ============== MODEL TO JSON CONVERSION ==============
  // Converts ProductModel back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': {
        'rate': rating,
        'count': ratingCount,
      },
    };
  }
}

// lib/models/product.dart
// ============================================================================
// PRODUCT MODEL
// ============================================================================
// This model represents a Product entity from the API.
// It includes JSON serialization for converting API responses to Dart objects.
// ============================================================================
class Product {
  // Unique identifier for the product
  final int? id;
  // Product name (required)
  final String name;
  // Product description (optional)
  final String? description;
  // Product price (required) - sent as string, parsed to double
  final String price;
  // Product stock quantity (required)
  final int stock;
  // Product category (optional)
  final String? category;
  // Product image URL (optional, returned from API)
  final String? image;

  // Constructor with all parameters
  Product({
    this.id,
    required this.name,
    this.description,
    required this.price,
    required this.stock,
    this.category,
    this.image,
  });
  // ========================================================================
  // JSON SERIALIZATION - Convert API JSON to Product Object
  // ========================================================================
  // Factory constructor to create a Product from JSON response
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int?,
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      price: json['price'] as String? ?? '0.0',
      stock: json['stock'] as int? ?? 0,
      category: json['category'] as String?,
      image: json['image'] as String?,
    );
  }

  // ========================================================================
  // JSON DESERIALIZATION - Convert Product Object to JSON for API Request
  // ========================================================================
  // Convert Product to JSON for POST/PUT requests
  // Note: id and image are not sent (read-only from API)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'category': category,
    };
  }
  // ========================================================================
  // COPY WITH METHOD - Create a modified copy of the product
  // ========================================================================
  // Useful for updating specific fields without modifying the original
  Product copyWith({
    int? id,
    String? name,
    String? description,
    String? price,
    int? stock,
    String? category,
    String? image,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      category: category ?? this.category,
      image: image ?? this.image,
    );
  }

  // ========================================================================
  // UTILITY METHODS
  // ========================================================================
  
  @override
  String toString() => 'Product(id: $id, name: $name, price: $price, stock: $stock)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          price == other.price &&
          stock == other.stock;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ price.hashCode ^ stock.hashCode;
}

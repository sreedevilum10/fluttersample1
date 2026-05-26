// lib/model/product_model.dart

class Product {
  final int    id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int    stock;
  final String brand;
  final String thumbnail;
  final List<String> images;
  final String returnPolicy;
  final String shippingInformation;
  final List<Review> reviews;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.thumbnail,
    required this.images,
    required this.returnPolicy,
    required this.shippingInformation,
    required this.reviews,
  });

  factory Product.fromJson(Map<String, dynamic> j) => Product(
        id:                  j['id'],
        title:               j['title'] ?? '',
        description:         j['description'] ?? '',
        category:            j['category'] ?? '',
        price:               (j['price'] as num).toDouble(),
        discountPercentage:  (j['discountPercentage'] as num).toDouble(),
        rating:              (j['rating'] as num).toDouble(),
        stock:               j['stock'] ?? 0,
        brand:               j['brand'] ?? 'Generic',
        thumbnail:           j['thumbnail'] ?? '',
        images:              List<String>.from(j['images'] ?? []),
        returnPolicy:        j['returnPolicy'] ?? '',
        shippingInformation: j['shippingInformation'] ?? '',
        reviews: (j['reviews'] as List? ?? [])
            .map((r) => Review.fromJson(r))
            .toList(),
      );

  // Final price after discount
  double get finalPrice => price - (price * discountPercentage / 100);
  bool get isLowStock => stock > 0 && stock <= 10;
}

class Review {
  final int    rating;
  final String comment;
  final String reviewerName;

  Review({required this.rating, required this.comment, required this.reviewerName});
  factory Review.fromJson(Map<String, dynamic> j) => Review(
        rating:       j['rating'] ?? 0,
        comment:      j['comment'] ?? '',
        reviewerName: j['reviewerName'] ?? '',
      );
}

class ProductModelRivv {
  final int id;
  final String title;
  final double price;
  final String image;

  ProductModelRivv({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  factory ProductModelRivv.fromJson(Map<String, dynamic> json) {
    return ProductModelRivv(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
    );
  }
}
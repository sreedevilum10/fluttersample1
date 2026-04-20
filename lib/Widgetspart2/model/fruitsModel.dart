// ================= MODEL =================
class Fruit {
  final int id;
  final String name;
  final String color;
  final String image;
  final double? rating;
  final int? price;

  Fruit({
    required this.id,
    required this.name,
    required this.color,
    required this.image,
    this.rating,
    this.price,
  });
}

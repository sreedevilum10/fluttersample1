import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/productModel.dart';

final productProvider =
Provider<List<ProductModel>>((ref) {
  return [
    ProductModel(
      id: 1,
      title: "Laptop",
      price: 50000,
    ),

    ProductModel(
      id: 2,
      title: "Phone",
      price: 25000,
    ),

    ProductModel(
      id: 3,
      title: "Headset",
      price: 3000,
    ),
  ];
});
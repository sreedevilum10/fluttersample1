// lib/service/product_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/product_model.dart';

class ProductService {
  Future<List<Product>> fetchProducts() async {
    final res = await http
        .get(Uri.
    parse('https://dummyjson.com/products?limit=100'))
        .timeout(const Duration(seconds: 15));

    if (res.statusCode == 200) {
      final data = json.decode(res.body);
      return (data['products'] as List)
          .map((j) => Product.fromJson(j))
          .toList();
    }
    throw Exception('Failed to load products');
  }
}

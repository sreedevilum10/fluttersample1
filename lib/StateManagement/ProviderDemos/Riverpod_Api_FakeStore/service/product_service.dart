import 'dart:convert';
import 'package:fluttersample1/StateManagement/ProviderDemos/Riverpod_Api_FakeStore/model/ProductModelRiv.dart';
import 'package:http/http.dart' as http;


class ProductService {
  Future<List<ProductModelRivv>> fetchProducts() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      return data.map((e) => ProductModelRivv.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
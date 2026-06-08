// Import Dio HTTP client library
import 'package:dio/dio.dart';
// Import ProductModel for conversion
import '../models/product_model.dart';
// ============== REMOTE DATA SOURCE INTERFACE ==============
// Abstract class defining how to fetch products from network
abstract class ProductRemoteDataSource {
  // Get all products from API
  Future<List<ProductModel>> getProducts();
  // Get products for specific category
  Future<List<ProductModel>> getProductsByCategory(String category);
}

// ============== REMOTE DATA SOURCE IMPLEMENTATION ==============
// Concrete implementation that uses Dio to make HTTP requests
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  // Dio instance for making HTTP requests
  final Dio dio;
  // Constructor: requires Dio instance
  ProductRemoteDataSourceImpl(this.dio);

  // Base URL for FakeStore API
  final String _baseUrl = 'https://fakestoreapi.com/products';
  // ============== METHOD 1: GET ALL PRODUCTS ==============
  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      // Make GET request to API
      final response = await dio.get(_baseUrl);
      // Check if request was successful (200 = success)
      if (response.statusCode == 200) {
        // response.data = the JSON body from API
        final List<dynamic> jsonList = response.data;
        // Convert each JSON item to ProductModel
        return jsonList.map((json) =>
            ProductModel.fromJson(json as Map<String, dynamic>)).toList();
      } else {
        // Status code not 200 = error
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // DioException = error from Dio library
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      // Any other error
      throw Exception('Error: $e');
    }
  }

  // ============== METHOD 2: GET PRODUCTS BY CATEGORY ==============
  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      // Construct URL with category
      // Example: '/products/category/electronics'
      final response = await dio.get('$_baseUrl/category/$category');

      // Check if successful
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = response.data;
        return jsonList
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

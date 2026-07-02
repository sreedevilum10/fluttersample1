// lib/services/product_service.dart
// ============================================================================
// PRODUCT API SERVICE - WITH AUTHENTICATION SUPPORT
// ============================================================================
// This service handles all HTTP communication with the Product API.
// It acts as the Repository layer in MVVM architecture.
// UPDATED: Now includes Authorization header for authenticated requests.
// ============================================================================
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  // ========================================================================
  // CONSTANTS
  // ========================================================================
  // Base URL for the Luminar Free API
  static const String baseUrl =
      'https://freeapi.luminartechnohub.com';
  // API timeout duration (in seconds)
  static const Duration timeoutDuration =
        Duration(seconds: 30);

  // ========================================================================
  // INSTANCE VARIABLES
  // ========================================================================
  // Store the authentication token
  String? _authToken;
  // ========================================================================
  // PRIVATE CONSTRUCTOR - Singleton pattern
  // ========================================================================
  ProductService._();
  // Create a static instance (Singleton)
  static final ProductService _instance =
              ProductService._();
  // Factory constructor returns the singleton instance
  factory ProductService() {
    return _instance;
  }
  // ========================================================================
  // TOKEN MANAGEMENT
  // ========================================================================
  /// Sets the authentication token for API requests
  /// Call this after successful login to enable authenticated requests
  /// Example:
  /// ```dart
  /// String token = await authService.login(...);
  /// productService.setAuthToken(token);
  /// ```
  void setAuthToken(String token) {
    _authToken = token;
    print('🔐 Auth token set for ProductService');
  }
  /// Clears the authentication token (useful on logout)
  void clearAuthToken() {
    _authToken = null;
    print('🗑️ Auth token cleared');
  }
  /// Gets the current authorization headers
  /// Private helper method that builds the headers map
  /// including the Authorization header if token is available
  Map<String, String> _getHeaders() {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    // Add Authorization header if token is available
    if (_authToken != null && _authToken!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $_authToken';
      print('✅ Auth header added to request');
    } else {
      print('⚠️ No auth token available - '
          'request may fail with 401');
    }
    return headers;
  }

  // ========================================================================
  // 1. FETCH ALL PRODUCTS - GET /products-all/
  // ========================================================================
  /// Fetches all products from the API
  /// 
  /// Returns a list of [Product] objects
  /// Throws an exception if the request fails
  /// 
  /// Example:
  /// ```dart
  /// List<Product> products = await ProductService().fetchAllProducts();
  /// ```
  Future<List<Product>> fetchAllProducts() async {
    try {
      // Create the full URL
      final url = Uri.parse('$baseUrl/products-all/');
      print('📍 Fetching products from: $url');
      // Get headers with auth token
      final headers = _getHeaders();
      // Make the GET request with timeout
      final response = await http.get(
          url, headers: headers).timeout(timeoutDuration);
      print('📊 Response Status: ${response.statusCode}');
      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Decode the JSON response
        final dynamic decodedBody = jsonDecode(
            response.body);
        // Handle different response formats
        // The API might return a list directly or wrapped in an object
        List<dynamic> productsJson;
        if (decodedBody is List) {
          // If response is a list, use it directly
          productsJson = decodedBody;
        } else if (decodedBody is Map &&
                  decodedBody.containsKey('results')) {
          // If wrapped in an object with 'results' key
          productsJson = decodedBody['results']
                  as List<dynamic>;
        } else if (decodedBody is Map &&
                  decodedBody.containsKey('data')) {
          // If wrapped in an object with 'data' key
          productsJson = decodedBody['data']
                  as List<dynamic>;
        } else {
          // Default to treating as list
          productsJson = decodedBody is List
                                      ? decodedBody
                                      : [];
        }
        print('✅ Successfully fetched ${productsJson.length}'
            ' products');
        // Convert each JSON item to a Product object
        return productsJson.map((item) => Product.
            fromJson(item as Map<String, dynamic>)).toList();
      } else if (response.statusCode == 401) {
        // Unauthorized - Token missing or invalid
        throw Exception('Unauthorized (401): '
            'Authentication required. Please login first.');
      } else if (response.statusCode == 403) {
        // Forbidden - Token valid but user doesn't have permission
        throw Exception('Forbidden (403): '
            'You do not have permission to access products.');
      } else {
        // If status code is not 200, throw an error
        throw Exception('Failed to fetch products. Status: '
            '${response.statusCode}');
      }
    } catch (e) {
      // Log error for debugging
      print('❌ Error fetching products: $e');
      rethrow; // Re-throw to let the caller handle the error
    }
  }

  // ========================================================================
  // 2. CREATE PRODUCT - POST /product-create/
  // ========================================================================
  /// Creates a new product via the API
  /// 
  /// Takes a [Product] object as input
  /// Returns the created product with the ID assigned by the server
  /// Throws an exception if the request fails
  /// 
  /// Example:
  /// ```dart
  /// Product newProduct = Product(
  ///   name: 'Laptop',
  ///   price: '999.99',
  ///   stock: 10,
  /// );
  /// Product createdProduct = await ProductService().createProduct(newProduct);
  /// ```
  Future<Product> createProduct(Product product) async {
    try {
      // Create the full URL
      final url = Uri.parse('$baseUrl/product-create/');
      print('📍 Creating product at: $url');
      // Convert product to JSON
      final productJson = product.toJson();
      print('📝 Product data: $productJson');
      // Get headers with auth token
      final headers = _getHeaders();
      // Make the POST request with JSON body
      final response = await http.post(url,
            headers: headers,
            body: jsonEncode(productJson),
          ).timeout(timeoutDuration);
      print('📊 Response Status: ${response.statusCode}');


      // Check response status
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Decode and return the created product
        final createdProductJson = jsonDecode(response.body) as Map<String, dynamic>;
        final createdProduct = Product.fromJson(createdProductJson);
        print('✅ Product created successfully with ID: ${createdProduct.id}');
        return createdProduct;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized (401): Authentication required. Please login first.');
      } else if (response.statusCode == 403) {
        throw Exception('Forbidden (403): You do not have permission to create products.');
      } else if (response.statusCode == 400) {
        // Handle validation errors
        final errorBody = jsonDecode(response.body);
        print('⚠️ Validation error: $errorBody');
        throw Exception('Validation error: $errorBody');
      } else {
        // Handle other errors
        throw Exception('Failed to create product. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error creating product: $e');
      rethrow;
    }
  }

  // ========================================================================
  // 3. UPDATE PRODUCT - PUT /product-update/{id}/
  // ========================================================================
  /// Updates an existing product via the API
  /// 
  /// Takes the product [id] and a [Product] object with updated values
  /// Returns the updated product from the server
  /// Throws an exception if the request fails
  /// 
  /// Example:
  /// ```dart
  /// Product updatedProduct = Product(
  ///   name: 'Updated Laptop',
  ///   price: '899.99',
  ///   stock: 15,
  /// );
  /// await ProductService().updateProduct(123, updatedProduct);
  /// ```
  Future<Product> updateProduct(int id, Product product) async {
    try {
      // Create the full URL with the product ID
      final url = Uri.parse('$baseUrl/product-update/$id/');

      print('📍 Updating product at: $url');
      // Convert product to JSON (exclude id and image)
      final productJson = product.toJson();
      print('📝 Updated data: $productJson');

      // Get headers with auth token
      final headers = _getHeaders();

      // Make the PUT request
      final response = await http.put(
            url,
            headers: headers,
            body: jsonEncode(productJson),
          )
          .timeout(timeoutDuration);

      print('📊 Response Status: ${response.statusCode}');

      // Check response status
      if (response.statusCode == 200) {
        // Decode and return the updated product
        final updatedProductJson = jsonDecode(response.body) as Map<String, dynamic>;
        final updatedProduct = Product.fromJson(updatedProductJson);
        print('✅ Product updated successfully');
        return updatedProduct;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized (401): Authentication required. Please login first.');
      } else if (response.statusCode == 403) {
        throw Exception('Forbidden (403): You do not have permission to update products.');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found (404): Product with ID $id does not exist.');
      } else if (response.statusCode == 400) {
        // Handle validation errors
        final errorBody = jsonDecode(response.body);
        print('⚠️ Validation error: $errorBody');
        throw Exception('Validation error: $errorBody');
      } else {
        // Handle other errors
        throw Exception('Failed to update product. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error updating product: $e');
      rethrow;
    }
  }

  // ========================================================================
  // 4. DELETE PRODUCT - DELETE /product-delete/{id}/
  // ========================================================================
  /// Deletes a product from the API
  /// 
  /// Takes the product [id] to delete
  /// Returns true if successful, throws exception on failure
  /// 
  /// Example:
  /// ```dart
  /// await ProductService().deleteProduct(123);
  /// ```
  Future<bool> deleteProduct(int id) async {
    try {
      // Create the full URL with the product ID
      final url = Uri.parse('$baseUrl/product-delete/$id/');

      print('📍 Deleting product at: $url');

      // Get headers with auth token (DELETE requests still need auth)
      final headers = {
        'Accept': 'application/json',
      };

      if (_authToken != null && _authToken!.isNotEmpty) {
        headers['Authorization'] = 'Bearer $_authToken';
        print('✅ Auth header added to request');
      } else {
        print('⚠️ No auth token available - request may fail with 401');
      }

      // Make the DELETE request
      final response = await http.delete(
            url,
            headers: headers,
          ).timeout(timeoutDuration);

      print('📊 Response Status: ${response.statusCode}');

      // Check response status
      // API returns 204 No Content on successful deletion
      if (response.statusCode == 204 || response.statusCode == 200) {
        print('✅ Product deleted successfully');
        return true;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized (401): Authentication required. Please login first.');
      } else if (response.statusCode == 403) {
        throw Exception('Forbidden (403): You do not have permission to delete products.');
      } else if (response.statusCode == 404) {
        throw Exception('Not Found (404): Product with ID $id does not exist.');
      } else {
        throw Exception('Failed to delete product. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error deleting product: $e');
      rethrow;
    }
  }
}

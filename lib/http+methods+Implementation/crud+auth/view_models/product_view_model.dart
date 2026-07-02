// lib/view_models/product_view_model.dart
// ============================================================================
// PRODUCT VIEW MODEL
// ============================================================================
// This ViewModel contains all business logic for product CRUD operations.
// It acts as the mediator between the View (UI) and the Service (API layer).
// Uses Provider for state management and notification.
// UPDATED: Now integrates with authentication token from AuthService
// ============================================================================

import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/product_service.dart';

class ProductViewModel extends ChangeNotifier {
  // ========================================================================
  // DEPENDENCIES
  // ========================================================================
  // Instance of the product service for API calls
  final ProductService _productService;

  // ========================================================================
  // STATE VARIABLES
  // ========================================================================
  // List to store all products
  List<Product> _products = [];

  // Flag to indicate if products are being loaded
  bool _isLoading = false;

  // Error message to display to the user
  String? _errorMessage;

  // Currently selected product for editing
  Product? _selectedProduct;

  // ========================================================================
  // CONSTRUCTOR
  // ========================================================================
  ProductViewModel({ProductService? productService}) : _productService = productService ?? ProductService();

  // ========================================================================
  // GETTERS - Expose state to the UI
  // ========================================================================
  /// Returns the list of all products
  List<Product> get products => _products;
  /// Returns true if products are currently being loaded
  bool get isLoading => _isLoading;
  /// Returns the current error message, if any
  String? get errorMessage => _errorMessage;

  /// Returns the currently selected product for editing
  Product? get selectedProduct => _selectedProduct;

  /// Returns the total number of products
  int get productCount => _products.length;

  /// Returns the total inventory value
  double get totalInventoryValue {
    return _products.fold<double>(0, (sum, product) {
      double price = double.tryParse(product.price) ?? 0;
      return sum + (price * product.stock);
    });
  }

  // ========================================================================
  // PUBLIC METHODS - Business Logic
  // ========================================================================

  // ========================================================================
  // 0. SET AUTHENTICATION TOKEN
  // ========================================================================
  /// Sets the authentication token from the auth service
  /// Call this after successful login to enable product API access
  ///
  /// Parameters:
  /// - [token] The JWT token from login
  ///
  /// Example:
  /// ```dart
  /// String token = await authService.login(...);
  /// productViewModel.setAuthToken(token);
  /// ```
  void setAuthToken(String token) {
    _productService.setAuthToken(token);
    print('🔑 ProductViewModel: Auth token set');
  }

  /// Clears the authentication token (call on logout)
  void clearAuthToken() {
    _productService.clearAuthToken();
    _products = [];
    _selectedProduct = null;
    _errorMessage = null;
    notifyListeners();
    print('🔑 ProductViewModel: Auth token cleared');
  }

  // ========================================================================
  // 1. FETCH ALL PRODUCTS
  // ========================================================================
  /// Fetches all products from the API
  /// Updates the UI when complete via notifyListeners()
  Future<void> fetchAllProducts() async {
    try {
      // Set loading state
      _setLoading(true);
      _clearError();
      // Call the service to fetch products
      final products = await _productService.
        fetchAllProducts();
      // Update the products list
      _products = products;
      // Sort products by name for better UX
      _products.sort((a, b) => a.name.compareTo(b.name));
      // Notify listeners to rebuild UI
      notifyListeners();
    } catch (e) {
      // Handle error
      _setError('Failed to fetch products: ${e.toString()}');
    } finally {
      // Clear loading state
      _setLoading(false);
    }
  }

  // ========================================================================
  // 2. CREATE PRODUCT
  // ========================================================================
  /// Creates a new product via the API
  ///
  /// Parameters:
  /// - [name] Product name
  /// - [price] Product price as string
  /// - [stock] Available stock quantity
  /// - [description] Optional product description
  /// - [category] Optional product category
  ///
  /// Returns true if successful, false otherwise
  Future<bool> createProduct({
    required String name,
    required String price,
    required int stock,
    String? description,
    String? category,
  }) async {
    try {
      // Set loading state
      _setLoading(true);
      _clearError();

      // Validate inputs
      if (name.isEmpty) {
        _setError('Product name cannot be empty');
        return false;
      }

      if (double.tryParse(price) == null) {
        _setError('Invalid price format');
        return false;
      }

      if (stock < 0) {
        _setError('Stock cannot be negative');
        return false;
      }
      // Create product object
      final newProduct = Product(
        name: name,
        price: price,
        stock: stock,
        description: description,
        category: category,
      );

      // Call service to create product
      final createdProduct =
      await _productService.createProduct(newProduct);

      // Add the created product to the list
      _products.add(createdProduct);
      // Sort the list
      _products.sort((a, b) =>
          a.name.compareTo(b.name));
      // Notify listeners
      notifyListeners();
      return true;
    } catch (e) {
      // Handle error
      _setError('Failed to create product: '
          '${e.toString()}');
      return false;
    } finally {
      // Clear loading state
      _setLoading(false);
    }
  }

  // ========================================================================
  // 3. UPDATE PRODUCT
  // ========================================================================
  /// Updates an existing product via the API
  ///
  /// Parameters:
  /// - [id] The product ID to update
  /// - [name] Updated product name
  /// - [price] Updated product price
  /// - [stock] Updated stock quantity
  /// - [description] Updated product description
  /// - [category] Updated product category
  ///
  /// Returns true if successful, false otherwise
  Future<bool> updateProduct({
    required int id,
    required String name,
    required String price,
    required int stock,
    String? description,
    String? category,
  }) async {
    try {
      // Set loading state
      _setLoading(true);
      _clearError();

      // Validate inputs
      if (name.isEmpty) {
        _setError('Product name cannot be empty');
        return false;
      }

      if (double.tryParse(price) == null) {
        _setError('Invalid price format');
        return false;
      }

      if (stock < 0) {
        _setError('Stock cannot be negative');
        return false;
      }

      // Create updated product object
      final updatedProduct = Product(
        id: id,
        name: name,
        price: price,
        stock: stock,
        description: description,
        category: category,
      );

      // Call service to update product
      final result = await _productService.updateProduct(id, updatedProduct);

      // Find and update the product in the local list
      final index = _products.indexWhere((p) => p.id == id);
      if (index != -1) {
        _products[index] = result;
      }

      // Sort the list
      _products.sort((a, b) => a.name.compareTo(b.name));

      // Clear selected product
      _selectedProduct = null;

      // Notify listeners
      notifyListeners();

      return true;
    } catch (e) {
      // Handle error
      _setError('Failed to update product: ${e.toString()}');
      return false;
    } finally {
      // Clear loading state
      _setLoading(false);
    }
  }

  // ========================================================================
  // 4. DELETE PRODUCT
  // ========================================================================
  /// Deletes a product from the API
  ///
  /// Parameters:
  /// - [id] The product ID to delete
  ///
  /// Returns true if successful, false otherwise
  Future<bool> deleteProduct(int id) async {
    try {
      // Set loading state
      _setLoading(true);
      _clearError();

      // Call service to delete product
      await _productService.deleteProduct(id);

      // Remove the product from the local list
      _products.removeWhere((p) => p.id == id);

      // If deleted product was selected, clear it
      if (_selectedProduct?.id == id) {
        _selectedProduct = null;
      }

      // Notify listeners
      notifyListeners();

      return true;
    } catch (e) {
      // Handle error
      _setError('Failed to delete product: ${e.toString()}');
      return false;
    } finally {
      // Clear loading state
      _setLoading(false);
    }
  }

  // ========================================================================
  // 5. SELECT PRODUCT FOR EDITING
  // ========================================================================
  /// Selects a product for editing
  ///
  /// Parameters:
  /// - [product] The product to select
  void selectProduct(Product product) {
    _selectedProduct = product;
    _clearError();
    notifyListeners();
  }

  // ========================================================================
  // 6. CLEAR SELECTION
  // ========================================================================
  /// Clears the currently selected product
  void clearSelection() {
    _selectedProduct = null;
    _clearError();
    notifyListeners();
  }

  // ========================================================================
  // PRIVATE HELPER METHODS
  // ========================================================================

  /// Sets the loading state and notifies listeners
  void _setLoading(bool value) {
    _isLoading = value;
  }

  /// Sets an error message and notifies listeners
  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  /// Clears the current error message
  void _clearError() {
    _errorMessage = null;
  }
}

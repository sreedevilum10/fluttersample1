// Import Product entity
import '../entities/product.dart';

// ============== PRODUCT REPOSITORY INTERFACE ==============
// Abstract class = blueprint for concrete implementations
// Defines what operations can be performed with products
abstract class ProductRepository {
  // Get all products from API
  // Future<List<Product>> = returns list of products in the future
  Future<List<Product>> getProducts();
  
  // Get products by specific category
  // Parameter: category = which category to filter by
  // Example: getProductsByCategory('electronics')
  Future<List<Product>> getProductsByCategory(String category);
}

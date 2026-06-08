// Import Product entity
import '../entities/product.dart';
// Import repository interface
import '../repositories/product_repository.dart';
// ============== USE CASE 1: GET ALL PRODUCTS ==============
// Use case = single business operation
// Fetches all products from API
class GetProductsUseCase {
  // Store repository reference (dependency injection)
  final ProductRepository repository;
  // Constructor: requires repository
  GetProductsUseCase(this.repository);

  // Main method: call() returns all products
  // async = this operation takes time (network request)
  Future<List<Product>> call() async {
    // Delegate to repository to fetch products
    return await repository.getProducts();
  }
}

// ============== USE CASE 2: GET PRODUCTS BY CATEGORY ==============
// Use case = single business operation
// Fetches products filtered by category
class GetProductsByCategoryUseCase {
  // Store repository reference
  final ProductRepository repository;
  // Constructor
  GetProductsByCategoryUseCase(this.repository);
  // Main method: call(category)
  // category = which category to fetch (e.g., 'electronics')
  Future<List<Product>> call(String category) async {
    // Delegate to repository with category filter
    return await repository.getProductsByCategory(category);
  }
}

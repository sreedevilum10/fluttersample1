// Import Product entity
import '../../domain/entities/product.dart';
// Import repository interface
import '../../domain/repositories/product_repository.dart';
// Import data source
import '../datasources/product_remote_datasource.dart';

// ============== PRODUCT REPOSITORY IMPLEMENTATION ==============
// Implements the abstract ProductRepository interface
// Bridge between domain (business logic) and data (API calls)
class ProductRepositoryImpl implements ProductRepository {
  // Reference to data source (Dio API calls)
  final ProductRemoteDataSource remoteDataSource;
  // Constructor: requires data source
  ProductRepositoryImpl(this.remoteDataSource);

  // ============== IMPLEMENT METHOD 1: GET PRODUCTS ==============
  @override
  Future<List<Product>> getProducts() async {
    try {
      // Call data source to get products from API
      return await remoteDataSource.getProducts();
    } catch (e) {
      // If any error occurs, re-throw with message
      throw Exception('Failed to get products: $e');
    }
  }
  // ============== IMPLEMENT METHOD 2: GET PRODUCTS BY CATEGORY ==============
  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      // Call data source with category parameter
      return await remoteDataSource.getProductsByCategory(category);
    } catch (e) {
      throw Exception('Failed to get products by category: $e');
    }
  }
}

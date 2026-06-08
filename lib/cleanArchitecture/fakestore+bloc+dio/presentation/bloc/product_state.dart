// Import Equatable
import 'package:equatable/equatable.dart';
// Import Product entity
import '../../domain/entities/product.dart';
// ============== BASE STATE CLASS ==============
// Abstract base class for all states
// States represent different UI conditions
abstract class ProductState extends Equatable {
  const ProductState();
  @override
  List<Object?> get props => [];
}

// ============== STATE 1: INITIAL ==============
// State: App just started, no data loaded yet
class ProductInitial extends ProductState {
  const ProductInitial();
}

// ============== STATE 2: LOADING ==============
// State: Fetching products from API
// UI shows: spinning indicator
class ProductLoading extends ProductState {
  const ProductLoading();
}

// ============== STATE 3: LOADED ==============
// State: Successfully loaded products
// UI shows: grid of product cards
class ProductLoaded extends ProductState {
  // Hold list of products
  final List<Product> products;
  const ProductLoaded(this.products);
  // Override props to include products for comparison
  @override
  List<Object?> get props => [products];
}

// ============== STATE 4: ERROR ==============
// State: Something went wrong
// UI shows: error message with retry button
class ProductError extends ProductState {
  // Error message to show user
  final String message;
  const ProductError(this.message);

  // Override props to include message for comparison
  @override
  List<Object?> get props => [message];
}

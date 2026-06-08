// Import Equatable for comparing events
import 'package:equatable/equatable.dart';
// ============== BASE EVENT CLASS ==============
// Abstract base class for all events
// Events represent user actions that trigger changes
abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object?> get props => [];
}
// ============== EVENT 1: FETCH PRODUCTS ==============
// Event: App started, fetch all products
class FetchProductsEvent extends ProductEvent {
  const FetchProductsEvent();
}
// ============== EVENT 2: FETCH BY CATEGORY ==============
// Event: User selected category, fetch filtered products
class FetchProductsByCategoryEvent extends ProductEvent {
  // Store which category was selected
  final String category;
  // Constructor: requires category
  const FetchProductsByCategoryEvent(this.category);
  // Override props to include category for comparison
  @override
  List<Object?> get props => [category];
}

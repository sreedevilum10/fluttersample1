// Import flutter_bloc library
import 'package:flutter_bloc/flutter_bloc.dart';
// Import use cases
import '../../domain/usecases/get_products_usecase.dart';
// Import events and states
import 'product_event.dart';
import 'product_state.dart';

// ============== PRODUCT BLOC ==============
// BLoC = Business Logic Component
// Receives events → Calls use cases → Emits states
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  // ============== DEPENDENCIES ==============
  // Inject both use cases
  final GetProductsUseCase getProductsUseCase;
  final GetProductsByCategoryUseCase
  getProductsByCategoryUseCase;

  // ============== CONSTRUCTOR ==============
  ProductBloc({
    required this.getProductsUseCase,
    required this.getProductsByCategoryUseCase,
  }) : super(const ProductInitial()) {
    // super(const ProductInitial()) = initial state when app starts
    
    // ============== REGISTER EVENT HANDLERS ==============
    // When FetchProductsEvent arrives, call _onFetchProducts
    on<FetchProductsEvent>(_onFetchProducts);
    // When FetchProductsByCategoryEvent arrives, call _onFetchProductsByCategory
    on<FetchProductsByCategoryEvent>(_onFetchProductsByCategory);
  }

  // ============== HANDLER 1: FETCH ALL PRODUCTS ==============
  // Called when FetchProductsEvent is received
  Future<void> _onFetchProducts(
    FetchProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    // Step 1: Emit loading state (shows spinner to user)
    emit(const ProductLoading());
    // Step 2: Try to fetch products
    try {
      // Call use case to get all products
      final products = await getProductsUseCase.call();
      // Step 3: Success! Emit loaded state with counter data
      emit(ProductLoaded(products));
    } catch (e) {
      // Step 3: Error occurred - emit error state
      emit(ProductError(e.toString()));
    }
  }

  // ============== HANDLER 2: FETCH BY CATEGORY ==============
  // Called when FetchProductsByCategoryEvent is received
  Future<void> _onFetchProductsByCategory(
    FetchProductsByCategoryEvent event,
    Emitter<ProductState> emit,
  ) async {
    // Step 1: Emit loading state
    emit(const ProductLoading());
    // Step 2: Try to fetch products for category
    try {
      // Call use case with category parameter
      final products = await
      getProductsByCategoryUseCase.call(event.category);
      // Step 3: Success! Emit loaded state
      emit(ProductLoaded(products));
    } catch (e) {
      // Step 3: Error occurred
      emit(ProductError(e.toString()));
    }
  }
}

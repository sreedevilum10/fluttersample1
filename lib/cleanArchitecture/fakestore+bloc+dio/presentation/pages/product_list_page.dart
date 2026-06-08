// Import Flutter material
import 'package:flutter/material.dart';
// Import flutter_bloc
import 'package:flutter_bloc/flutter_bloc.dart';
// Import BLoC and events/states
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
// Import product card widget
import '../widgets/product_card_widget.dart';
// ============== PRODUCT LIST PAGE ==============
// StatefulWidget = manages its own state (selected category)
class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);
  @override
  State<ProductListPage> createState() =>
      _ProductListPageState();
}
// ============== STATE CLASS ==============
// State = UI state (selected category)
class _ProductListPageState extends State<ProductListPage> {
  // ============== PROPERTIES ==============
  // Track which category is selected
  // String? = can be null or string
  // null = no category selected (showing all)
  String? selectedCategory;
  // ============== LIFECYCLE ==============
  // initState = runs once when page loads
  @override
  void initState() {
    super.initState();
    // When page loads, fetch all products
    context.read<ProductBloc>()
        .add(const FetchProductsEvent());
  }

  // ============== BUILD WIDGET ==============
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ============== APP BAR ==============
      appBar: AppBar(
        title: const Text('FakeStore Products'),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
      ),
      
      // ============== BODY ==============
      body: Column(
        children: [
          // ============== FILTER SECTION ==============
          Container(
            color: Colors.blue.shade700,
            padding: const EdgeInsets.all(16),
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                const Text(
                  'Filter by Category',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // ============== CATEGORY BUTTONS ==============
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  
                  child: Row(
                    children: [
                      _buildCategoryButton('All', null),
                      _buildCategoryButton('Electronics', 'electronics'),
                      _buildCategoryButton('Jewelery', 'jewelery'),
                      _buildCategoryButton('Men\'s', 'men\'s clothing'),
                      _buildCategoryButton('Women\'s', 'women\'s clothing'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ============== PRODUCTS GRID ==============
          Expanded(
            // BlocBuilder = rebuild when state changes
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                // ============== LOADING STATE ==============
                if (state is ProductLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                // ============== LOADED STATE ==============
                else if (state is ProductLoaded) {
                  if (state.products.isEmpty) {
                    return const Center(
                      child: Text('No products found'),
                    );
                  }
                  
                  // Show grid of products
                  return GridView.builder(
                    padding: const EdgeInsets.all(8),
                    
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.6,
                    ),
                    
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return ProductCardWidget(
                        product: state.products[index],
                      );
                    },
                  );
                }
                // ============== ERROR STATE ==============
                else if (state is ProductError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 48,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text('Error: ${state.message}'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<ProductBloc>()
                                .add(const FetchProductsEvent());
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============== CATEGORY BUTTON BUILDER ==============
  // Helper method to build category buttons
  Widget _buildCategoryButton(String label, String? category) {
    // Check if this button is selected
    final isSelected = selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        // When button clicked
        onSelected: (selected) {
          // Update selected category
          setState(() {
            selectedCategory = selected ? category : null;
          });
          // Fetch products for selected category
          if (category == null) {
            context.read<ProductBloc>().add(const FetchProductsEvent());
          } else {
            context.read<ProductBloc>().add(FetchProductsByCategoryEvent(category));
          }
        },
        
        selectedColor: Colors.white,
        backgroundColor: Colors.blue[300],
        labelStyle: TextStyle(
          color: isSelected ? Colors.blue.shade700 : Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

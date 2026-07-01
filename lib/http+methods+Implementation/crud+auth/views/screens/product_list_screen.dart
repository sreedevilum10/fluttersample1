// lib/views/screens/product_list_screen.dart
// ============================================================================
// PRODUCT LIST SCREEN - WITH LOGOUT
// ============================================================================
// Displays all products with CRUD operations and logout functionality
// ============================================================================

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_models/product_view_model.dart';
import '../widgets/product_tile.dart';
import 'add_product_screen.dart';
import 'edit_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  final VoidCallback onLogout;

  const ProductListScreen({
    Key? key,
    required this.onLogout,
  }) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch products when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductViewModel>().fetchAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Management'),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
        actions: [
          // Refresh button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              print('🔄 Refreshing products...');
              context.read<ProductViewModel>().fetchAllProducts();
            },
            tooltip: 'Refresh Products',
          ),

          // Logout button
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _showLogoutConfirmation,
            tooltip: 'Logout',
          ),
        ],
      ),

      body: Consumer<ProductViewModel>(
        builder: (context, viewModel, child) {
          // ================================================================
          // ERROR STATE
          // ================================================================
          if (viewModel.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red.shade300,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      viewModel.errorMessage ?? 'An error occurred',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      print('🔄 Retrying...');
                      viewModel.fetchAllProducts();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // ================================================================
          // LOADING STATE
          // ================================================================
          if (viewModel.isLoading && viewModel.products.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // ================================================================
          // EMPTY STATE
          // ================================================================
          if (viewModel.products.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No products found',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the + button to add your first product',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            );
          }

          // ================================================================
          // PRODUCTS LIST STATE
          // ================================================================
          return RefreshIndicator(
            onRefresh: () => viewModel.fetchAllProducts(),
            child: Column(
              children: [
                // ============================================================
                // SUMMARY HEADER
                // ============================================================
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.blue.shade50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Total products
                      _buildSummaryItem(
                        label: 'Total Products',
                        value: viewModel.productCount.toString(),
                        icon: Icons.inventory_2,
                      ),

                      // Inventory value
                      _buildSummaryItem(
                        label: 'Inventory Value',
                        value: '\$${viewModel.totalInventoryValue.toStringAsFixed(2)}',
                        icon: Icons.price_check,
                      ),
                    ],
                  ),
                ),

                // ============================================================
                // PRODUCTS LIST
                // ============================================================
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: viewModel.products.length,
                    itemBuilder: (context, index) {
                      final product = viewModel.products[index];

                      return ProductTile(
                        product: product,
                        onEdit: () {
                          print('✏️ Editing product: ${product.id}');
                          viewModel.selectProduct(product);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const EditProductScreen(),
                            ),
                          );
                        },
                        onDelete: () {
                          print('🗑️ Deleting product: ${product.id}');
                          _showDeleteConfirmation(context, product.id!, viewModel);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('➕ Adding new product');
          context.read<ProductViewModel>().clearSelection();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddProductScreen(),
            ),
          );
        },
        tooltip: 'Add Product',
        child: const Icon(Icons.add),
      ),
    );
  }

  // ========================================================================
  // HELPER METHODS
  // ========================================================================

  /// Builds a summary item widget
  Widget _buildSummaryItem({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue.shade700, size: 32),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  /// Shows logout confirmation dialog
  void _showLogoutConfirmation() {
    print('🚪 Logout requested');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          // Cancel button
          TextButton(
            onPressed: () {
              print('❌ Logout cancelled');
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),

          // Logout button
          TextButton(
            onPressed: () {
              print('✅ Logging out...');
              Navigator.pop(context);
              widget.onLogout();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  /// Shows delete confirmation dialog
  void _showDeleteConfirmation(
    BuildContext context,
    int productId,
    ProductViewModel viewModel,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          // Cancel button
          TextButton(
            onPressed: () {
              print('❌ Delete cancelled');
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),

          // Delete button
          TextButton(
            onPressed: () {
              print('✅ Deleting product $productId');
              Navigator.pop(context);
              viewModel.deleteProduct(productId);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

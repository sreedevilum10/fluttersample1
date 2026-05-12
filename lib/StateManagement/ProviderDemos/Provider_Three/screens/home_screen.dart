import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/theme_provider.dart';
import 'login_screen.dart';
import 'shop_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Reading multiple providers in one build method
    final auth = context.watch<AuthProvider>();
    final cart = context.watch<CartProvider>();
    final theme = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Hello, ${auth.displayName}'),
        backgroundColor: Theme.of(context)
            .colorScheme.inversePrimary,
        actions: [
          // Cart badge
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) =>
                  const CartScreen()),
                ),
              ),
              if (cart.itemCount > 0)
                Positioned(
                  top: 6,
                  right: 6,
                  child: CircleAvatar(
                    radius: 9,
                    backgroundColor: Colors.red,
                    child: Text(
                      '${cart.itemCount}',
                      style: const TextStyle(
                          fontSize: 11, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          // Theme toggle
          IconButton(
            icon: Icon(
                theme.isDarkMode
                    ? Icons.light_mode
                    : Icons.dark_mode),
            onPressed: () =>
                context.read<ThemeProvider>().toggleTheme(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Auth State Card ───────────────────────────────────
            Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(
                      auth.displayName[0].toUpperCase()),
                ),
                title: Text(auth.isLoggedIn
                    ? 'Logged in as ${auth.userName}'
                    : 'Not logged in'),
                subtitle: Text(auth.isLoggedIn
                    ? 'Tap to logout'
                    : 'Tap to login'),
                trailing: const Icon(
                    Icons.arrow_forward_ios),
                onTap: auth.isLoggedIn
                    ? () =>
                    context.read<AuthProvider>().logout()
                    : () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_)
                            => const LoginScreen()),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            // ── Cart Summary Card ─────────────────────────────────
            Card(
              child: ListTile(
                leading: const Icon(Icons.shopping_bag),
                title: Text('Cart: ${cart.itemCount} item(s)'),
                subtitle: Text(
                    'Total: \$${cart.totalPrice.
                    toStringAsFixed(2)}'),
                trailing: const Icon(
                    Icons.arrow_forward_ios),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder:
                      (_) => const CartScreen()),
                ),
              ),
            ),

            const SizedBox(height: 20),
            // ── Go Shopping Button ────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_)
                  => const ShopScreen()),
                ),
                icon: const Icon(Icons.storefront),
                label: const Text('Go to Shop'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

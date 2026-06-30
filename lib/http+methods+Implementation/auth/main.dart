// lib/main.dart
// ============================================================================
// MAIN APPLICATION ENTRY POINT
// ============================================================================
// Initializes the app with GetX state management and routing.
// ============================================================================
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/auth_controller.dart';
import 'views/login_screen.dart';
import 'views/register_screen.dart';
import 'views/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // ========================================================================
  // BUILD METHOD
  // ========================================================================
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // ====================================================================
      // APP CONFIGURATION
      // ====================================================================
      title: 'Flutter Auth GetX',
      debugShowCheckedModeBanner: false,

      // ====================================================================
      // THEME SETUP
      // ====================================================================
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),

      // ====================================================================
      // DEPENDENCY INJECTION (GetX Service Locator)
      // ====================================================================
      // This section initializes controllers and services before the app runs
      initialBinding: BindingsBuilder(() {
        // Register the AuthController as a singleton
        // This makes it available throughout the app via Get.find()
        Get.put(AuthController(), permanent: true);
      }),

      // ====================================================================
      // INITIAL ROUTE SETUP
      // ====================================================================
      // Determine the starting screen based on authentication status
      home: FutureBuilder<void>(
        future: _initializeApp(),
        builder: (context, snapshot) {
          // Show loading while initializing
          if (snapshot.connectionState
              == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          // After initialization, use the routing logic
          return const _RootScreen();
        },
      ),

      // ====================================================================
      // NAVIGATION ROUTES (GetX Named Routes)
      // ====================================================================
      // Define all named routes for the application
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }

  // ========================================================================
  // INITIALIZATION METHOD
  // ========================================================================
  /// Initializes the app by checking authentication status
  Future<void> _initializeApp() async {
    // Get the AuthController
    final authController = Get.find<AuthController>();

    // Check if user is already authenticated
    await authController.checkAuthenticationStatus();
  }
}

// ============================================================================
// ROOT SCREEN - Determines which screen to show
// ============================================================================
/// This widget acts as the root and decides navigation based on auth status
class _RootScreen extends StatelessWidget {
  const _RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    // Use Obx to listen to authentication changes
    return Obx(() {
      // If user is authenticated, show home screen
      if (authController.isAuthenticated.value) {
        return const HomeScreen();
      }
      // Otherwise, show login screen
      return const LoginScreen();
    });
  }
}

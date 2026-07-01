// lib/main.dart
// ============================================================================
// MAIN APPLICATION - COMPLETE INTEGRATED SOLUTION
// ============================================================================
// Login + Product CRUD Combined
// Handles authentication, token management, and product operations
// ============================================================================

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'services/product_service.dart';
import 'view_models/product_view_model.dart';
import 'views/screens/product_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductViewModel(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Product CRUD + Auth',
        debugShowCheckedModeBanner: false,
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
            centerTitle: false,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blue.shade700, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
          ),
          cardTheme: CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}

// ============================================================================
// AUTH WRAPPER - Routes based on authentication state
// ============================================================================
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);
  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool? isAuthenticated;
  String? token;
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  /// Checks if user has a saved token from previous login
  Future<void> _checkAuthentication() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedToken = prefs.getString('auth_token');

      if (savedToken != null && savedToken.isNotEmpty) {
        // Restore token in services
        ProductService().setAuthToken(savedToken);
        context.read<ProductViewModel>().setAuthToken(savedToken);
        
        print('✅ Token restored from storage');
      }

      setState(() {
        isAuthenticated = savedToken != null && savedToken.isNotEmpty;
        token = savedToken;
      });
    } catch (e) {
      print('❌ Error checking authentication: $e');
      setState(() {
        isAuthenticated = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Loading state - checking for saved token
    if (isAuthenticated == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              const Text('Loading...'),
            ],
          ),
        ),
      );
    }
    // User is authenticated - show products
    if (isAuthenticated == true && token != null) {
      return ProductListScreen(
        onLogout: _handleLogout,
      );
    }
    // User is not authenticated - show login
    return LoginScreen(
      onLoginSuccess: _handleLoginSuccess,
    );
  }
  /// Handles successful login
  Future<void> _handleLoginSuccess(String newToken) async {
    // Set token in services
    ProductService().setAuthToken(newToken);
    context.read<ProductViewModel>().setAuthToken(newToken);

    // Save token
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', newToken);

    setState(() {
      isAuthenticated = true;
      token = newToken;
    });

    print('✅ Login successful');
  }

  /// Handles logout
  Future<void> _handleLogout() async {
    // Clear token from storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');

    // Clear services
    ProductService().clearAuthToken();
    context.read<ProductViewModel>().clearAuthToken();

    setState(() {
      isAuthenticated = false;
      token = null;
    });

    print('✅ Logged out');
  }
}

// ============================================================================
// LOGIN SCREEN
// ============================================================================
class LoginScreen extends StatefulWidget {
  final Function(String) onLoginSuccess;

  const LoginScreen({
    Key? key,
    required this.onLoginSuccess,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  String? errorMessage;
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade700, Colors.blue.shade900],
          ),
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ========================================================
                    // ICON
                    // ========================================================
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lock_outline,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ========================================================
                    // TITLE
                    // ========================================================
                    const Text(
                      'Product Manager',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Login to manage your products',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 48),

                    // ========================================================
                    // ERROR MESSAGE
                    // ========================================================
                    if (errorMessage != null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          border: Border.all(color: Colors.red.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.red.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                errorMessage!,
                                style: TextStyle(
                                  color: Colors.red.shade700,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    // ========================================================
                    // EMAIL FIELD
                    // ========================================================
                    TextField(
                      controller: emailController,
                      enabled: !isLoading,
                      decoration: InputDecoration(
                        hintText: 'Email address',
                        prefixIcon: const Icon(Icons.email),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),

                    // ========================================================
                    // PASSWORD FIELD
                    // ========================================================
                    TextField(
                      controller: passwordController,
                      enabled: !isLoading,
                      obscureText: !showPassword,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() => showPassword = !showPassword);
                          },
                          icon: Icon(
                            showPassword ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // ========================================================
                    // LOGIN BUTTON
                    // ========================================================
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: isLoading ? null : _handleLogin,
                        icon: isLoading
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Icon(Icons.login),
                        label: Text(
                          isLoading ? 'Logging in...' : 'Login',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // ========================================================
         /*           // INFO BOX
                    // ========================================================
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'API Information',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '• Endpoint: https://freeapi.luminartechnohub.com/login\n'
                            '• Requires: Email & Password\n'
                            '• Returns: Bearer Token\n'
                            '• Use your Luminar API credentials',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.8),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),*/
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Handles login button press
  Future<void> _handleLogin() async {
    // Validation
    if (emailController.text.isEmpty) {
      setState(() => errorMessage = 'Please enter your email');
      return;
    }

    if (passwordController.text.isEmpty) {
      setState(() => errorMessage = 'Please enter your password');
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      print('🔐 Login attempt: ${emailController.text}');

      // Make API call
      final response = await http
          .post(
            Uri.parse('https://freeapi.luminartechnohub.com/login'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'email': emailController.text.trim(),
              'password': passwordController.text,
            }),
          )
          .timeout(const Duration(seconds: 30));

      print('🔐 Response Status: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse response
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        // Extract token (try different formats)
        String? token;
        if (data.containsKey('access')) {
          token = data['access'] as String;
        } else if (data.containsKey('token')) {
          token = data['token'] as String;
        } else if (data.containsKey('access_token')) {
          token = data['access_token'] as String;
        } else {
          // Try first value
          final firstValue = data.values.first;
          if (firstValue is String) {
            token = firstValue;
          }
        }

        if (token != null && token.isNotEmpty) {
          print('✅ Token received: ${token.substring(0, 20)}...');
          widget.onLoginSuccess(token);
        } else {
          setState(() => errorMessage = 'No token in response');
        }
      } else if (response.statusCode == 401) {
        setState(() => errorMessage = 'Invalid email or password');
        print('❌ Unauthorized: Invalid credentials');
      } else if (response.statusCode == 400) {
        setState(() => errorMessage = 'Validation error. Check your input.');
        print('❌ Bad request: ${response.body}');
      } else {
        setState(() => errorMessage = 'Login failed (${response.statusCode})');
        print('❌ Error: ${response.statusCode} - ${response.body}');
      }
    } on SocketException {
      setState(() => errorMessage = 'No internet connection');
      print('❌ Network error');

    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

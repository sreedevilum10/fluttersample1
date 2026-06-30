// lib/controllers/auth_controller.dart
// ============================================================================
// AUTH CONTROLLER
// ============================================================================
// Contains all authentication business logic using GetX state management.
// Acts as the Controller in the MVC architecture.
// ============================================================================

import 'package:get/get.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  // ========================================================================
  // DEPENDENCIES
  // ========================================================================
  final AuthService authService;
  // ========================================================================
  // STATE VARIABLES (REACTIVE)
  // ========================================================================
  // Observable variables - UI automatically rebuilds when these change
  // Current authentication state
  final Rx<bool> isAuthenticated = false.obs;
  // Loading state
  final Rx<bool> isLoading = false.obs;
  // Error message
  final Rx<String?> errorMessage = Rx<String?>(null);
  // Currently logged-in user
  final Rx<User?> currentUser = Rx<User?>(null);
  // Auth token
  final Rx<String?> authToken = Rx<String?>(null);

  // ========================================================================
  // CONSTRUCTOR
  // ========================================================================
  AuthController({AuthService? authService})
      : authService = authService ?? AuthService();

  // ========================================================================
  // INITIALIZATION
  // ========================================================================
  /// Called when the controller is first initialized
  @override
  void onInit() {
    super.onInit();
    print('🚀 AuthController initialized');
    // Check if user is already authenticated on app startup
    checkAuthenticationStatus();
  }

  // ========================================================================
  // 1. CHECK AUTHENTICATION STATUS
  // ========================================================================
  /// Checks if user is already authenticated (has valid token)
  /// Called on app startup to determine initial navigation
  Future<void> checkAuthenticationStatus() async {
    try {
      print('🔍 Checking authentication status...');
      // Get token from storage
      final token = await authService.getToken();

      if (token != null && token.isNotEmpty) {
        isAuthenticated.value = true;
        authToken.value = token;
        print('✅ User already authenticated');
      } else {
        isAuthenticated.value = false;
        print('❌ No authentication token found');
      }
    } catch (e) {
      print('❌ Error checking auth status: $e');
      isAuthenticated.value = false;
    }
  }

  // ========================================================================
  // 2. LOGIN METHOD
  // ========================================================================
  /// Authenticates user with email and password
  /// 
  /// Parameters:
  /// - [email] User's email
  /// - [password] User's password
  /// 
  /// Returns: true if login successful, false otherwise
  /// 
  /// Example:
  /// ```dart
  /// bool success = await authController.login(
  ///   email: 'user@example.com',
  ///   password: 'password123',
  /// );
  /// if (success) {
  ///   Get.offAllNamed('/home');
  /// }
  /// ```
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      // Validate inputs
      if (!_validateEmail(email)) {
        setError('Invalid email format');
        return false;
      }

      if (password.isEmpty) {
        setError('Password cannot be empty');
        return false;
      }

      // Set loading state
      isLoading.value = true;
      clearError();

      print('🔐 Attempting login for: $email');

      // Call the auth service
      final token = await authService.login(
        email: email,
        password: password,
      );
      // Update state
      isAuthenticated.value = true;
      authToken.value = token;
      currentUser.value = User(
        email: email,
        name: email.split('@')[0], // Extract name from email for now
        phone: 0,
        place: '',
        pincode: 0,
      );

      print('✅ Login successful');
      return true;
    } catch (e) {
      print('❌ Login failed: $e');
      setError('Login failed: ${e.toString()}');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // ========================================================================
  // 3. REGISTRATION METHOD
  // ========================================================================
  /// Registers a new user
  /// 
  /// Parameters:
  /// - [name] User's full name
  /// - [email] User's email
  /// - [password] User's password
  /// - [phone] User's phone number
  /// - [place] User's city/place
  /// - [pincode] User's postal code
  /// 
  /// Returns: true if registration successful, false otherwise
  /// 
  /// Example:
  /// ```dart
  /// bool success = await authController.register(
  ///   name: 'John Doe',
  ///   email: 'john@example.com',
  ///   password: 'password123',
  ///   phone: 9876543210,
  ///   place: 'New York',
  ///   pincode: 10001,
  /// );
  /// ```
  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required int phone,
    required String place,
    required int pincode,
  }) async {
    try {
      // ================================================================
      // VALIDATION
      // ================================================================
      // Validate name
      if (name.trim().isEmpty) {
        setError('Name cannot be empty');
        return false;
      }

      if (name.length < 3) {
        setError('Name must be at least 3 characters');
        return false;
      }

      // Validate email
      if (!_validateEmail(email)) {
        setError('Invalid email format');
        return false;
      }

      // Validate password
      if (password.isEmpty) {
        setError('Password cannot be empty');
        return false;
      }

      if (password.length < 6) {
        setError('Password must be at least 6 characters');
        return false;
      }

      // Validate password confirmation
      if (password != confirmPassword) {
        setError('Passwords do not match');
        return false;
      }

      // Validate phone
      if (phone <= 0) {
        setError('Invalid phone number');
        return false;
      }

      // Validate place
      if (place.trim().isEmpty) {
        setError('Place cannot be empty');
        return false;
      }

      // Validate pincode
      if (pincode <= 0) {
        setError('Invalid pincode');
        return false;
      }

      // ================================================================
      // SET LOADING STATE
      // ================================================================
      isLoading.value = true;
      clearError();

      print('📝 Attempting registration for: $email');

      // ================================================================
      // CALL AUTH SERVICE
      // ================================================================
      final user = await authService.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
        place: place,
        pincode: pincode,
      );
      // ================================================================
      // UPDATE STATE
      // ================================================================
      currentUser.value = user;
      print('✅ Registration successful');
      return true;
    } catch (e) {
      print('❌ Registration failed: $e');
      setError('Registration failed: ${e.toString()}');
      return false;
    } finally {
      isLoading.value = false;
    }
  }
  // ========================================================================
  // 4. LOGOUT METHOD
  // ========================================================================
  /// Logs out the current user
  /// Clears authentication data and token
  Future<void> logout() async {
    try {
      print('🚪 Logging out...');

      // Clear token from storage
      await authService.clearToken();

      // Reset state
      isAuthenticated.value = false;
      authToken.value = null;
      currentUser.value = null;
      clearError();

      print('✅ Logout successful');
    } catch (e) {
      print('❌ Logout failed: $e');
      setError('Logout failed: ${e.toString()}');
    }
  }

  // ========================================================================
  // PRIVATE HELPER METHODS
  // ========================================================================

  /// Validates email format using regex
  bool _validateEmail(String email) {
    // Simple email validation regex
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Sets an error message
  void setError(String message) {
    errorMessage.value = message;
  }

  /// Clears the error message
  void clearError() {
    errorMessage.value = null;
  }

  /// Gets formatted error message
  String? get error => errorMessage.value;
}

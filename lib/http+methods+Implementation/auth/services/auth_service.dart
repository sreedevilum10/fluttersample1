// lib/services/auth_service.dart
// ============================================================================
// AUTH API SERVICE
// ============================================================================
// Handles all authentication API calls (login and registration).
// Repository layer for authentication operations.
// ============================================================================
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class AuthService {
  // ========================================================================
  // CONSTANTS
  // ========================================================================
  static const String baseUrl = 'https://freeapi.luminartechnohub.com';
  static const Duration timeoutDuration = Duration(seconds: 30);

  // SharedPreferences keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';

  // ========================================================================
  // SINGLETON PATTERN
  // ========================================================================
  AuthService._();

  static final AuthService _instance = AuthService._();

  factory AuthService() {
    return _instance;
  }

  // ========================================================================
  // 1. LOGIN ENDPOINT
  // ========================================================================
  /// Authenticates user with email and password
  ///
  /// Parameters:
  /// - [email] User's email address
  /// - [password] User's password
  ///
  /// Returns: Auth token on successful login
  /// Throws: Exception on failure
  ///
  /// Example:
  /// ```dart
  /// String token = await AuthService().login(
  ///   email: 'user@example.com',
  ///   password: 'password123'
  /// );
  /// ```
  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      // Create the full URL
      final url = Uri.parse('$baseUrl/login');

      // Prepare request body
      final body = jsonEncode({'email': email, 'password': password});

      print('🔐 Login Request: email=$email');
      // Make the POST request
      final response = await http.post(url,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: body,
          ).timeout(timeoutDuration);

      print('🔐 Login Response Status: ${response.statusCode}');
      print('🔐 Login Response Body: ${response.body}');

      // Check response status
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Decode the response
        final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
        // Extract token - The API might return token in different formats
        String token;
        if (decodedResponse.containsKey('access')) {
          token = decodedResponse['access'] as String;
        } else if (decodedResponse.containsKey('token')) {
          token = decodedResponse['token'] as String;
        } else {
          // Try to extract any string value that might be the token
          token = decodedResponse.values.first.toString();
        }

        // Save token to SharedPreferences
        await _saveToken(token);

        print('🔐 Login Successful - Token saved');
        return token;
      } else if (response.statusCode == 400) {
        // Handle validation errors
        final errorBody = jsonDecode(response.body);
        throw Exception(
          'Invalid email or password:'
          ' $errorBody',
        );
      } else if (response.statusCode == 401) {
        throw Exception(
          'Unauthorized: '
          'Invalid credentials',
        );
      } else {
        throw Exception(
          'Login failed with status:'
          ' ${response.statusCode}',
        );
      }
    } catch (e) {
      print('❌ Login Error: $e');
      rethrow;
    }
  }

  // ========================================================================
  // 2. REGISTRATION ENDPOINT
  // ========================================================================
  /// Registers a new user
  ///
  /// Parameters:
  /// - [name] User's full name
  /// - [email] User's email address
  /// - [password] User's password
  /// - [phone] User's phone number
  /// - [place] User's city/place
  /// - [pincode] User's postal code
  ///
  /// Returns: Registered User object
  /// Throws: Exception on failure
  ///
  /// Example:
  /// ```dart
  /// User user = await AuthService().register(
  ///   name: 'John Doe',
  ///   email: 'john@example.com',
  ///   password: 'password123',
  ///   phone: 9876543210,
  ///   place: 'New York',
  ///   pincode: 10001,
  /// );
  /// ```
  Future<User> register({
    required String name,
    required String email,
    required String password,
    required int phone,
    required String place,
    required int pincode,
  }) async {
    try {
      // Create the full URL
      final url = Uri.parse('$baseUrl/registration/');

      // Prepare request body
      final body = jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'place': place,
        'pincode': pincode,
      });

      print('📝 Registration Request: email=$email,'
          ' name=$name');

      // Make the POST request
      final response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: body,
          )
          .timeout(timeoutDuration);

      print('📝 Registration Response Status: ${response.statusCode}');
      print('📝 Registration Response Body: ${response.body}');

      // Check response status
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Decode the response
        final decodedResponse =
            jsonDecode(response.body) as Map<String, dynamic>;

        // Create User from response (try different possible response structures)
        User user;
        if (decodedResponse.containsKey('user')) {
          user = User.fromJson(decodedResponse['user'] as Map<String, dynamic>);
        } else {
          // Assume the entire response is the user object
          user = User.fromJson(decodedResponse);
        }

        print('📝 Registration Successful - User created');
        return user;
      } else if (response.statusCode == 400) {
        // Handle validation errors
        final errorBody = jsonDecode(response.body);
        throw Exception('Validation error: $errorBody');
      } else {
        throw Exception(
          'Registration failed with status: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('❌ Registration Error: $e');
      rethrow;
    }
  }

  // ========================================================================
  // TOKEN MANAGEMENT
  // ========================================================================

  /// Saves token to SharedPreferences
  Future<void> _saveToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(tokenKey, token);
      print('💾 Token saved to SharedPreferences');
    } catch (e) {
      print('❌ Error saving token: $e');
    }
  }

  /// Retrieves saved token from SharedPreferences
  Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(tokenKey);
      print('📖 Token retrieved: ${token != null
          ? 'Present' : 'Not found'}');
      return token;
    } catch (e) {
      print('❌ Error getting token: $e');
      return null;
    }
  }

  /// Clears the stored token (logout)
  Future<void> clearToken() async {
    try {
      final prefs = await SharedPreferences
          .getInstance();
      await prefs.remove(tokenKey);
      await prefs.remove(userKey);
      print('🗑️ Token cleared - User logged out');
    } catch (e) {
      print('❌ Error clearing token: $e');
    }
  }

  /// Checks if user is authenticated
  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}

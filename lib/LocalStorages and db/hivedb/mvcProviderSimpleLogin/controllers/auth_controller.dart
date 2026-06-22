// lib/controllers/auth_controller.dart

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../models/usermodel.dart';

/// Auth Controller - MVC Controller Pattern
/// Handles all authentication logic
class AuthController extends ChangeNotifier {
  late Box<User> _usersBox;
  // Current logged-in user
  User? _currentUser;
  
  // State variables
  bool _isLoggedIn = false;
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  /// Initialize Hive box
  Future<void> init() async {
    try {
      _usersBox = Hive.box<User>('users');
      print('Users count: ${_usersBox.length}');
      for (var user in _usersBox.values) {
        print(user.runtimeType);
      }
      print('✅ Hive initialized');
    } catch (e) {
      print('❌ Error: $e');
      _errorMessage = 'Database error';
      notifyListeners();
    }
  }
  /// Clear messages
  void clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }

  /// Register new user
  Future<bool> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      clearMessages();
      _isLoading = true;
      notifyListeners();

      // Validation
      if (username.isEmpty || email.isEmpty
          || password.isEmpty) {
        _errorMessage = 'All fields required';
        _isLoading = false;
        notifyListeners();
        return false;
      }
      if (password != confirmPassword) {
        _errorMessage = 'Passwords do not match';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      if (password.length < 6) {
        _errorMessage = 'Password must be 6+ characters';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Check if email exists
      for (var user in _usersBox.values) {
        if (user.email == email.trim()) {
          _errorMessage = 'Email already registered';
          _isLoading = false;
          notifyListeners();
          return false;
        }
      }
      // Create new user
      final newUser = User(
        id: const Uuid().v4(),//to create unique ids
        username: username.trim(),
        email: email.trim(),
        password: password,
        createdAt: DateTime.now(),
      );

      // Save to Hive
      await _usersBox.add(newUser);
      _successMessage = 'Registration successful! '
          'Please login.';
      _isLoading = false;
      notifyListeners();
      print('✅ User registered: ${newUser.username}');
      return true;
    } catch (e) {
      _errorMessage = 'Error: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Login user
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      clearMessages();
      _isLoading = true;
      notifyListeners();

      // Validation
      if (email.isEmpty || password.isEmpty) {
        _errorMessage = 'Email and password required';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Find user
      User? user;
      for (var u in _usersBox.values) {
        if (u.email == email.trim()) {
          user = u;
          break;
        }
      }

      // Check user exists
      if (user == null) {
        _errorMessage = 'User not found';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Check password
      if (user.password != password) {
        _errorMessage = 'Invalid password';
        _isLoading = false;
        notifyListeners();
        return false;
      }

      // Login successful
      _currentUser = user;
      _isLoggedIn = true;
      _successMessage = 'Login successful!';
      _isLoading = false;
      notifyListeners();

      print('✅ Logged in: ${user.username}');
      return true;
    } catch (e) {
      _errorMessage = 'Error: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Logout user
  void logout() {
    _currentUser = null;
    _isLoggedIn = false;
    clearMessages();
    print('✅ Logged out');
    notifyListeners();
  }

  /// Get all users (for testing)
  List<User> getAllUsers() {
    return _usersBox.values.toList();
  }
}

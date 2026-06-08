import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {

  bool _isLoading = false;
  String? _errorMessage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Dummy stored user
  String registeredEmail = "admin@gmail.com";
  String registeredPassword = "123456";

  // LOGIN
  Future<bool> login(String email,
      String password,) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(
      const Duration(seconds: 2),
    );

    if (email == registeredEmail &&
        password == registeredPassword) {
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _isLoading = false;
      _errorMessage =
      "Invalid Email or Password";
      notifyListeners();
      return false;
    }
  }

  // REGISTER
  Future<bool> register(String email,
      String password,) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    await Future.delayed(
      const Duration(seconds: 2),
    );

    registeredEmail = email;
    registeredPassword = password;
    _isLoading = false;
    notifyListeners();
    return true;
  }
}
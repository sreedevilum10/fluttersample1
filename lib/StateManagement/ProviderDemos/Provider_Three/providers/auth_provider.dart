import 'package:flutter/foundation.dart';
/// AuthProvider manages the logged-in user state.
/// In a real app this would call an authentication API.
class AuthProvider extends ChangeNotifier {
  String? _userName;

  bool get isLoggedIn => _userName != null;
  String? get userName => _userName;
  String get displayName => _userName ?? 'Guest';

  /// Simulates login — sets the user name and notifies listeners.
  void login(String name) {
    _userName = name.trim().isEmpty ? 'User' : name.trim();
    notifyListeners();
  }

  /// Logs the user out.
  void logout() {
    _userName = null;
    notifyListeners();
  }
}

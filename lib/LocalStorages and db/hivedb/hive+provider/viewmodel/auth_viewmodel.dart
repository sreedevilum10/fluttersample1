import 'package:flutter/material.dart';
import 'package:fluttersample1/LocalStorages%20and%20db/hivedb/hive+provider/models/user.dart';

import '../services/auth_service.dart';


class AuthViewModel extends ChangeNotifier {
  final HiveService _service = HiveService();

  bool isLoading = false;

  Future<bool> register(
      String username, String password) async {
    isLoading = true;
    notifyListeners();

    UserModel user = UserModel(
      username: username,
      password: password,
    );

    bool result = await _service.register(user);
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future<bool> login(String username, String password) async {
    isLoading = true;
    notifyListeners();
    bool result = await _service.login(username, password);
    isLoading = false;
    notifyListeners();

    return result;
  }
}
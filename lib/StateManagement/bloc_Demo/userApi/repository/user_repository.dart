// ============================================================
// REPOSITORY LAYER
// Sits between the BLoC (ViewModel) and the ApiService.
// In bigger apps this is where caching, offline storage,
// or multiple data sources would be combined.
// ============================================================

import '../model/user_model.dart';
import '../service/api_service.dart';

class UserRepository {
  final ApiService apiService;

  UserRepository({required this.apiService});

  Future<List<User>> getUsers() {
    return apiService.fetchUsers();
  }
}

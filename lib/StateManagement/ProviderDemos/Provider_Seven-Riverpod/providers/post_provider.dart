import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersample1/StateManagement/ProviderDemos/Provider_Seven-Riverpod/models/post_model.dart' show PostModel;
import 'package:fluttersample1/StateManagement/ProviderDemos/Provider_Seven-Riverpod/services/api_service.dart' show ApiService;

// CREATE provider for Apiservice
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final postProvider = FutureProvider<List<PostModel>>((ref) async {
  final apiService = ref.read(apiServiceProvider);
  return apiService.fetchPosts();
});
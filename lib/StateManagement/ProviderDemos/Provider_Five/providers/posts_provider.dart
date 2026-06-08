import 'package:flutter/foundation.dart';

import '../models/post.dart';
import '../services/post_service.dart';

/// Enum representing the three states of any async operation.
enum ViewState { idle, loading, error }

/// PostsProvider is the STATE LAYER.
/// It delegates all HTTP work to PostService and translates the
/// result into a state that widgets can react to.
class PostsProvider extends ChangeNotifier {
  // ── Dependencies ───────────────────────────────────────────────
  final PostService _service = PostService();
  List<Post> _posts = [];
  String _errorMessage = '';
  bool _isLoading = false;

  // ── Getters ────────────────────────────────────────────────────
  String get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  List<Post> get posts => _posts;

  // ── API Methods ────────────────────────────────────────────────
  Future<void> fetchPost() async {
    _isLoading = true;
    notifyListeners();
    try {
      _posts = await _service.fetchPosts();
    } catch (e) {
      _errorMessage = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }
}

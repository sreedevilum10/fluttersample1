import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class PostService {
  final String _baseUrl = "https://jsonplaceholder.typicode.com";
  Future<List<Post>> fetchPosts() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/posts'),
    );
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => Post.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}

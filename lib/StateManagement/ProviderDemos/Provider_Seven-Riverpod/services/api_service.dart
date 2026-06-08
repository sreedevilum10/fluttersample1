import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/post_model.dart';

class ApiService {
  Future<List<PostModel>> fetchPosts() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      return jsonData
          .map((e) => PostModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Failed to load posts");
    }
  }
}
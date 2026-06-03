// ============================================================
// SERVICE LAYER
// Only this class knows about HTTP. Everything above it
// just calls fetchUsers() and gets back a List<User>.
// ============================================================
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<User>> fetchUsers() async {
    final url = Uri.parse('$_baseUrl/users');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList
          .map((item) => User.fromJson(item as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
          'Failed to load users — status ${response.statusCode}');
    }
  }
}

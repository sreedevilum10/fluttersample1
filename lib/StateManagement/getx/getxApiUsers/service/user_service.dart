import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';

class UserService {
  Future<List<User>> getUsers() async {
    final url      =
    Uri.parse('https://jsonplaceholder.typicode.com/users');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) =>
          User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}

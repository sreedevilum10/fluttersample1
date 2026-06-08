import 'package:dio/dio.dart';

import '../model/user_model.dart';

class ApiServiceDio {
  final Dio dio = Dio();
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<UserModel>> getUsers() async {
    final response = await dio.get('$_baseUrl/users');
    return (response.data as List)
        .map((e) => UserModel.fromJson(e)).toList();
  }
}

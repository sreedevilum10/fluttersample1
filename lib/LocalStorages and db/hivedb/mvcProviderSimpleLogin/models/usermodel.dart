// lib/models/usermodel.dart
import 'package:hive/hive.dart';
part 'usermodel.g.dart';

/// User Model - Simple data model for storing user information
@HiveType(typeId: 0) // 0-223
class User extends HiveObject {
  @HiveField(0)   //0-255
  late String id;

  @HiveField(1)
  late String username;

  @HiveField(2)
  late String email;

  @HiveField(3)
  late String password;

  @HiveField(4)
  late DateTime createdAt;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.createdAt,
  });

  @override
  String toString() => 'User(id: $id, username: $username, email: $email)';
}

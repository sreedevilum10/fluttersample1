// lib/models/user.dart
// ============================================================================
// USER MODEL
// ============================================================================
// Represents a User entity with profile information.
// ============================================================================

class User {
  // Unique identifier
  final int? id;

  // User's full name
  final String name;

  // User's email address
  final String email;

  // User's phone number
  final int phone;

  // User's place/city
  final String place;

  // User's postal code
  final int pincode;

  // Constructor
  User({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.place,
    required this.pincode,
  });

  // ========================================================================
  // JSON SERIALIZATION
  // ========================================================================
  
  /// Create User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as int? ?? 0,
      place: json['place'] as String? ?? '',
      pincode: json['pincode'] as int? ?? 0,
    );
  }

  /// Convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'place': place,
      'pincode': pincode,
    };
  }

  @override
  String toString() => 'User(id: $id, name: $name, email: $email)';
}

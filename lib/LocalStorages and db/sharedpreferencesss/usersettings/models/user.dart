// This file contains the User class
// A model class represents data in your app

class User {
  // ============ VARIABLES ============
  // User's full name
  final String name;
  // User's email address
  final String email;
  // User's phone number
  final String phone;
  // User's age
  final int age;

  // ============ CONSTRUCTOR ============
  
  // Constructor creates a User object with all required fields
  // All parameters are named parameters (specified with this.fieldName)
  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.age,
  });

  // ============ FACTORY CONSTRUCTORS ============
  
  // Factory constructor creates a User with default values
  // Used when no data exists yet (first app launch)
  factory User.empty() {
    return User(
      name: '',                    // Empty name
      email: '',                   // Empty email
      phone: '',                   // Empty phone
      age: 0,                      // Age 0
    );
  }

  // ============ COPY WITH METHOD ============
  
  // copyWith creates a new User with some fields changed, others kept same
  // Useful when updating just one field without changing others
  User copyWith({
    String? name,
    String? email,
    String? phone,
    int? age,
    bool? notificationsEnabled,
    bool? darkModeEnabled,
  }) {
    return User(
      name: name ?? this.name,  // Use new name if provided, else keep old
      email: email ?? this.email,
      phone: phone ?? this.phone,
      age: age ?? this.age,
    );
  }

  // ============ CONVERSION METHODS ============
  
  // Convert User object to Map (dictionary)
  // Used when saving to SharedPreferences (must convert to primitive types)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'age': age,

    };
  }

  // Create User object from Map
  // Used when loading from SharedPreferences
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      age: map['age'] as int? ?? 0,

    );
  }
  // ============ DISPLAY METHOD ============
  // toString() is called when printing User object
  // Useful for debugging
  @override
  String toString() {
    return 'User(name: $name, email: $email, phone: $phone, age: $age)';
  }
}

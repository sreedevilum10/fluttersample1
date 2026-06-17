// Contact model - represents a single contact
class Contact {
  final int? id;
  final String name;
  final String phone;
  final String icon;
  final DateTime createdAt;

  Contact({
    this.id,
    required this.name,
    required this.phone,
    required this.icon,
    required this.createdAt,
  });

  // Copy with - create a new Contact with some fields changed
  Contact copyWith({
    int? id,
    String? name,
    String? phone,
    String? icon,
    DateTime? createdAt,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      icon: icon ?? this.icon,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Convert to Map for database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'icon': icon,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create from Map from database
  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'] as int?,
      name: map['name'] as String,
      phone: map['phone'] as String,
      icon: map['icon'] as String,
      createdAt: DateTime.parse(map['createdAt']
      as String),
    );
  }

  @override
  String toString() => 'Contact('
      'id: $id, '
      'name: $name, '
      'phone: $phone, '
      'icon: $icon)';

  @override
  bool operator == (Object other) {
    if (identical(this, other)) return true;
    return other is Contact &&
        other.id == id &&
        other.name == name &&
        other.phone == phone &&
        other.icon == icon &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => Object.
  hash(id, name, phone, icon, createdAt);
}

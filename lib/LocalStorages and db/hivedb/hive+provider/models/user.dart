class UserModel {
  final String username;
  final String password;

  UserModel({required this.username, required this.password});

  Map<String, dynamic> toMap() {
    return {'username': username, 'password': password};
  }

  factory UserModel.fromMap(Map data) {
    return UserModel(username: data['username'],
        password: data['password']);
  }
}

import 'package:fluttersample1/dio+bloc+mvvm/model/user_model.dart';

abstract class UsersState {}

class UserInitial extends UsersState {}

class UserLoading extends UsersState {}

class UserLoaded extends UsersState {
  final List<UserModel> users;
  UserLoaded(this.users);
}

class UserError extends UsersState {
  final String message;
  UserError(this.message);
}
// ============================================================
// STATES
// Outputs from the BLoC — snapshots of what the screen
// should look like at a given moment.
// ============================================================
import 'package:equatable/equatable.dart';
import '../model/user_model.dart';

abstract class UserState extends Equatable {
  const UserState();
  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}
class UserLoading extends UserState {}
class UserLoaded extends UserState {
  final List<User> users;
  const UserLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

class UserError extends UserState {
  final String message;
  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}

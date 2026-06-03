// ============================================================
// EVENTS
// Inputs to the BLoC — things the user (or system) did.
// ============================================================
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class FetchUsers extends UserEvent {}

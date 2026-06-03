// ============================================================
// VIEWMODEL LAYER (BLoC)
// Receives events from the View, calls the Repository,
// and emits states back to the View.
// ============================================================
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;

  UserBloc({required this.repository}) : super(UserInitial()) {
    on<FetchUsers>(_onFetchUsers);
  }

  Future<void> _onFetchUsers(
      FetchUsers event, Emitter<UserState> emit)
  async {
    emit(UserLoading());
    try {
      final users = await repository.getUsers();
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}

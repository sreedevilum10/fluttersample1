import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersample1/dio+bloc+mvvm/service/api_service.dart';
import 'package:fluttersample1/dio+bloc+mvvm/viewmodel/user_bloc/users_state.dart';
part 'users_event.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final ApiServiceDio apiService;

  UsersBloc(this.apiService) : super(UserInitial()) {
    on<FetchUsers>(_fetchUsers);
  }

  Future<void> _fetchUsers(
      FetchUsers event,
      Emitter<UsersState> emit,
      ) async {
    emit(UserLoading());

    try {
      final users = await apiService.getUsers();
      emit(UserLoaded(users));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
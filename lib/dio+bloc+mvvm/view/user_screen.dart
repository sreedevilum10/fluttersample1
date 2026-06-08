import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersample1/dio+bloc+mvvm/viewmodel/user_bloc/users_bloc.dart';
import 'package:fluttersample1/dio+bloc+mvvm/viewmodel/user_bloc/users_state.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),

      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is UserLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user =
                state.users[index];
                return Card(
                  child: ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                  ),
                );
              },
            );
          }

          if (state is UserError) {
            return Center(
              child: Text(state.message),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
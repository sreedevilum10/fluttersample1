import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttersample1/dio+bloc+mvvm/service/api_service.dart';
import 'package:fluttersample1/dio+bloc+mvvm/view/user_screen.dart';
import 'package:fluttersample1/dio+bloc+mvvm/viewmodel/user_bloc/users_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => UsersBloc(
            ApiServiceDio())
          ..add(FetchUsers()),
        child: const UsersScreen(),
      ),
    );
  }
}
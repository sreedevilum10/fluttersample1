import 'package:flutter/material.dart';
import 'package:fluttersample1/LocalStorages%20and%20db/hivedb/hive+provider/screens/login_screen.dart';
import 'package:fluttersample1/LocalStorages%20and%20db/hivedb/hive+provider/viewmodel/auth_viewmodel.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
      false,
      home: LoginScreenHive(),
    );
  }
}
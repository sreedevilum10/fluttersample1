import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/posts_provider.dart';
import 'screens/posts_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostsProvider(),
      child: MaterialApp(
        title: 'Session 5 – API + Provider',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: PostScreen(),
      ),
    );
  }
}

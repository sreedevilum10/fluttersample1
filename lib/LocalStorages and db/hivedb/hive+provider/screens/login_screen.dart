import 'package:flutter/material.dart';
import 'package:fluttersample1/LocalStorages%20and%20db/hivedb/hive+provider/screens/home_screen.dart';
import 'package:fluttersample1/LocalStorages%20and%20db/hivedb/hive+provider/screens/register_screen.dart';
import 'package:provider/provider.dart';

import '../viewmodel/auth_viewmodel.dart';

class LoginScreenHive extends StatelessWidget {
  LoginScreenHive({super.key});
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding:
        const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller:
              usernameController,
              decoration:
              const InputDecoration(
                labelText: "Username",
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller:
              passwordController,
              obscureText: true,
              decoration:
              const InputDecoration(
                labelText: "Password",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (usernameController.text.trim().isEmpty ||
                    passwordController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          "Enter Username and Password"),
                    ),
                  );
                  return;
                }

                bool success = await vm.login(
                  usernameController.text.trim(),
                  passwordController.text.trim(),
                );
                if (success) {
                  String username = usernameController.text;
                  usernameController.clear();
                  passwordController.clear();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor:
                      Colors.green,
                      content: Text("Login Successful"),
                    ),
                  );

                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (_) => HomeScreenHive(
                        username: username,),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor:
                      Colors.red,
                      content: Text(
                          "Invalid Username or Password"),
                    ),
                  );
                }
              },
              child:
              const Text("Login"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        RegisterScreenHive(),
                  ),
                );
              },
              child: const Text(
                "Create Account",
              ),
            )
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/auth_viewmodel.dart';



class RegisterScreenHive extends StatelessWidget {
  RegisterScreenHive({super.key});

  final TextEditingController
  usernameController = TextEditingController();

  final TextEditingController
  passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
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
                          "All fields are required"),
                    ),
                  );
                  return;
                }

                bool result = await vm.register(
                  usernameController.text.trim(),
                  passwordController.text.trim(),
                );

                if (result) {
                  usernameController.clear();
                  passwordController.clear();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("Registration Successful"),
                    ),
                  );
                  Future.delayed(const Duration(seconds: 1),
                        () => Navigator.pop(context),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor:
                      Colors.red,
                      content: Text(
                          "Username Already Exists"),
                    ),
                  );
                }
              },
              child:
              const Text("Register"),
            )
          ],
        ),
      ),
    );
  }
}
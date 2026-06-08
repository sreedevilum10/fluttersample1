import 'package:flutter/material.dart';
import 'package:fluttersample1/StateManagement/ProviderDemos/LoginProvider/provider/auth_provider.dart';
import 'package:fluttersample1/StateManagement/ProviderDemos/LoginProvider/view/homeScreen.dart';
import 'package:provider/provider.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
        appBar: AppBar(
        title: const Text("Login"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration:
                const InputDecoration(
                  labelText: "Email",
                  border:
                  OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return "Enter Email";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller:
                passwordController,
                obscureText: true,
                decoration:
                const InputDecoration(
                  labelText: "Password",
                  border:
                  OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null ||
                      value.isEmpty) {
                    return "Enter Password";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),
              if (authProvider.errorMessage != null)
                Text(
                  authProvider.errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: authProvider.isLoading
                      ? null
                      : () async {
                    if (formKey.currentState!.validate()) {
                      bool success = await authProvider.
                             login(emailController.text.trim(),
                               passwordController.text.trim(),
                      );
                      if (success) {
                        Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => const HomeScreenLog(),
                          ),
                        );
                      }
                    }
                  },
                  child: authProvider.isLoading
                      ? const CircularProgressIndicator(color: Colors.white,)
                      : const Text("Login"),
                ),
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context, MaterialPageRoute(builder: (_) => RegisterScreen(),
                    ),
                  );
                },

                child: const Text(
                  "Create Account",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
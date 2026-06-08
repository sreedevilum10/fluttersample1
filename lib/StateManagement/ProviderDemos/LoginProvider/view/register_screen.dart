import 'package:flutter/material.dart';
import 'package:fluttersample1/StateManagement/ProviderDemos/LoginProvider/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // EMAIL
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

                  if (!value.contains("@")) {
                    return "Enter Valid Email";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // PASSWORD
              TextFormField(
                controller:
                passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border:
                  OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Password";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // CONFIRM PASSWORD
              TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText:
                  "Confirm Password",
                  border:
                  OutlineInputBorder(),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Confirm your password";
                  }
                  if (value != passwordController.text) {
                    return "Password does not match";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: authProvider.isLoading
                      ? null
                      : () async {
                    if (formKey
                        .currentState!
                        .validate()) {
                      await authProvider.register(emailController.text.trim(),
                        passwordController.text.trim(),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Registration Successful",
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },

                  child: authProvider.isLoading
                      ? const CircularProgressIndicator(color: Colors.white,)
                      : const Text("Register"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
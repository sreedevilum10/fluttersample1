import 'package:flutter/material.dart';
import 'package:fluttersample1/pages/regPageValidation.dart';

class GreenLoginPage extends StatefulWidget {
  const GreenLoginPage({super.key});

  @override
  State<GreenLoginPage> createState() => _GreenLoginPageState();
}

class _GreenLoginPageState extends State<GreenLoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // ✅ smoother keyboard behavior
      body: SizedBox.expand( // ✅ full screen
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0f5132),
                Color(0xFF198754),
                Color(0xFF20c997),
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 80),

                    const Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Login to continue",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),

                    const SizedBox(height: 40),

                    _buildField(
                      "Email",
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter email";
                        }
                        if (!value.contains("@")) {
                          return "Enter valid email";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    _buildField(
                      "Password",
                      controller: _passwordController,
                      isPassword: true,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return "Minimum 6 characters";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Login Successful 🎉"),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF20c997),
                          padding:
                          const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                const GreenRegistrationPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              color: Color(0xFF20c997),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(
      String hint, {
        bool isPassword = false,
        required TextEditingController controller,
        required String? Function(String?) validator,
      }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? isPasswordHidden : false,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
        TextStyle(color: Colors.white.withOpacity(0.6)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            isPasswordHidden
                ? Icons.visibility_off
                : Icons.visibility,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              isPasswordHidden = !isPasswordHidden;
            });
          },
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        errorStyle: const TextStyle(color: Colors.yellow),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
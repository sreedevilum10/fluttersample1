import 'package:flutter/material.dart';

class GreenRegistrationPage extends StatefulWidget {
  const GreenRegistrationPage({super.key});

  @override
  State<GreenRegistrationPage> createState() => _GreenRegistrationPageState();
}

class _GreenRegistrationPageState extends State<GreenRegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0f5132), Color(0xFF198754), Color(0xFF20c997)],
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // ✅ Form added
            child: Column(
              children: [
                Container(height: 4, color: Colors.white.withOpacity(0.1)),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const SizedBox(height: 36),
                      const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Secure and simple registration',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 28),

                      _buildGreenTextField(
                        'Full Name',
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter your name";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      _buildGreenTextField(
                        'Email',
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

                      const SizedBox(height: 12),

                      _buildGreenTextField(
                        'Password',
                        controller: _passwordController,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.length < 6) {
                            return "Minimum 6 characters";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      _buildGreenTextField(
                        'Confirm Password',
                        controller: _confirmPasswordController,
                        isPassword: true,
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (val) {
                              setState(() {
                                isChecked = val!;
                              });
                            },
                            activeColor: const Color(0xFF20c997),
                          ),
                          Expanded(
                            child: Text(
                              'I accept the Terms and Conditions',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (!isChecked) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Please accept Terms & Conditions",
                                    ),
                                  ),
                                );
                                return;
                              }

                              // ✅ Success
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Registration Successful 🎉"),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF20c997),
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Register Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already registered? ",
                            style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context); // ✅ back to login
                            },
                            child: const Text(
                              "Log In",
                              style: TextStyle(
                                color: Color(0xFF20c997),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGreenTextField(
    String hint, {
    bool isPassword = false,
    required TextEditingController controller,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: validator,
      // ✅ validation added
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.25)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.25)),
        ),
        errorStyle: const TextStyle(color: Colors.yellow),
        // visible error
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 13,
        ),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}

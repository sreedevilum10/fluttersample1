// lib/views/register_screen.dart
// ============================================================================
// REGISTRATION SCREEN
// ============================================================================
// User registration interface with complete profile form.
// ============================================================================

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // ========================================================================
  // CONTROLLERS
  // ========================================================================
  final authController = Get.find<AuthController>();

  // Form controllers
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController phoneController;
  late TextEditingController placeController;
  late TextEditingController pincodeController;

  // Form key for validation
  final formKey = GlobalKey<FormState>();

  // Show/hide password flags
  final showPassword = false.obs;
  final showConfirmPassword = false.obs;

  // ========================================================================
  // LIFECYCLE
  // ========================================================================
  @override
  void initState() {
    super.initState();

    // Initialize all text controllers
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    phoneController = TextEditingController();
    placeController = TextEditingController();
    pincodeController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    placeController.dispose();
    pincodeController.dispose();
    super.dispose();
  }

  // ========================================================================
  // BUILD METHOD
  // ========================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade700,
                Colors.blue.shade900,
              ],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    // ============================================================
                    // HEADER
                    // ============================================================
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Fill in your details to get started',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // ============================================================
                    // ERROR MESSAGE
                    // ============================================================
                    Obx(() {
                      if (authController.errorMessage.value != null) {
                        return Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            border: Border.all(color: Colors.red.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: Colors.red.shade700,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  authController.errorMessage.value!,
                                  style: TextStyle(
                                    color: Colors.red.shade700,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),

                    // ============================================================
                    // NAME FIELD
                    // ============================================================
                    _buildInputField(
                      controller: nameController,
                      label: 'Full Name *',
                      hint: 'Enter your full name',
                      icon: Icons.person_outline,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is required';
                        }
                        if (value.length < 3) {
                          return 'Name must be at least 3 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // ============================================================
                    // EMAIL FIELD
                    // ============================================================
                    _buildInputField(
                      controller: emailController,
                      label: 'Email *',
                      hint: 'Enter your email',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        if (!value.contains('@')) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // ============================================================
                    // PASSWORD FIELD
                    // ============================================================
                    Obx(() {
                      return _buildInputField(
                        controller: passwordController,
                        label: 'Password *',
                        hint: 'Enter password (min 6 characters)',
                        icon: Icons.lock_outline,
                        obscureText: !showPassword.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            showPassword.value = !showPassword.value;
                          },
                          icon: Icon(
                            showPassword.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      );
                    }),
                    const SizedBox(height: 16),

                    // ============================================================
                    // CONFIRM PASSWORD FIELD
                    // ============================================================
                    Obx(() {
                      return _buildInputField(
                        controller: confirmPasswordController,
                        label: 'Confirm Password *',
                        hint: 'Re-enter your password',
                        icon: Icons.lock_outline,
                        obscureText: !showConfirmPassword.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            showConfirmPassword.value = !showConfirmPassword.value;
                          },
                          icon: Icon(
                            showConfirmPassword.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm password is required';
                          }
                          if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      );
                    }),
                    const SizedBox(height: 16),

                    // ============================================================
                    // PHONE FIELD
                    // ============================================================
                    _buildInputField(
                      controller: phoneController,
                      label: 'Phone Number *',
                      hint: 'Enter 10-digit phone number',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone number is required';
                        }
                        if (value.length != 10) {
                          return 'Enter a valid 10-digit phone number';
                        }
                        if (!RegExp(r'^\d+$').hasMatch(value)) {
                          return 'Phone number must contain only digits';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // ============================================================
                    // PLACE FIELD
                    // ============================================================
                    _buildInputField(
                      controller: placeController,
                      label: 'City/Place *',
                      hint: 'Enter your city',
                      icon: Icons.location_on_outlined,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'City/Place is required';
                        }
                        if (value.length < 2) {
                          return 'Enter a valid city name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // ============================================================
                    // PINCODE FIELD
                    // ============================================================
                    _buildInputField(
                      controller: pincodeController,
                      label: 'Pincode *',
                      hint: 'Enter postal code',
                      icon: Icons.mail_outline,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Pincode is required';
                        }
                        if (!RegExp(r'^\d{5,6}$').hasMatch(value)) {
                          return 'Enter a valid pincode (5-6 digits)';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    // ============================================================
                    // REGISTER BUTTON
                    // ============================================================
                    Obx(() {
                      return SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton.icon(
                          onPressed: authController.isLoading.value
                              ? null
                              : _handleRegister,
                          icon: authController.isLoading.value
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : const Icon(Icons.app_registration),
                          label: Text(
                            authController.isLoading.value
                                ? 'Registering...'
                                : 'Register',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blue.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 16),

                    // ============================================================
                    // LOGIN LINK
                    // ============================================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ========================================================================
  // HELPER METHODS
  // ========================================================================

  /// Builds a customized input field widget
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
    required String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.red.shade300,
              ),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }

  /// Handles registration button press
  Future<void> _handleRegister() async {
    // Validate form
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Call register method from controller
    final success = await authController.register(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
      phone: int.parse(phoneController.text),
      place: placeController.text.trim(),
      pincode: int.parse(pincodeController.text),
    );

    // Navigate on success
    if (success) {
      Get.snackbar(
        'Success',
        'Registration successful! Please login.',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      // Navigate back to login
      Get.offNamed('/login');
    }
  }
}

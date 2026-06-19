import 'package:flutter/material.dart';

import '../models/user.dart';

// EditProfileScreen allows user to edit their profile information
// Receives user data and returns updated user data
class EditProfileScreen extends StatefulWidget {
  // User data to edit
  final User user;

  const EditProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

// _EditProfileScreenState manages form state
class _EditProfileScreenState extends State<EditProfileScreen> {
  // ============ FORM CONTROLLERS ============
  // Controller for name input field
  late TextEditingController _nameController;

  // Controller for email input field
  late TextEditingController _emailController;

  // Controller for phone input field
  late TextEditingController _phoneController;

  // Controller for age input field
  late TextEditingController _ageController;

  // ============ FORM STATE ============

  // Track if form is being submitted
  bool _isSubmitting = false;

  // Global key for form validation
  final _formKey = GlobalKey<FormState>();

  // ============ LIFECYCLE ============

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing user data
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone);
    _ageController = TextEditingController(
      text: widget.user.age > 0 ? widget.user.age.toString() : '',
    );
  }

  // ============ CLEANUP ============
  @override
  void dispose() {
    // Dispose all controllers to prevent memory leaks
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  // ============ FORM SUBMISSION ============
  // Handle save button press
  Future<void> _handleSave() async {
    // Validate form first
    if (!_formKey.currentState!.validate()) {
      return; // Stop if validation fails
    }
    // Show loading state
    setState(() {
      _isSubmitting = true;
    });
    try {
      // Simulate network delay (optional)
      await Future.delayed(const Duration(milliseconds: 500));
      // Create updated user object with form data
      User updatedUser = widget.user.copyWith(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        age: int.tryParse(_ageController.text) ?? 0,
      );
      // Return to previous screen with updated user
      // The home screen will receive this data
      if (mounted) {
        Navigator.pop(context, updatedUser);
      }
    } catch (e) {
      // Show error if something goes wrong
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          SnackBar(content: Text('Error: $e'),
              backgroundColor: Colors.red),
        );
      }
    } finally {
      // Stop loading state
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  // ============ INPUT VALIDATORS ============
  // Validate name field
  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required'; // Show error if empty
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters'; // Check minimum length
    }
    return null; // Valid
  }

  // Validate email field
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    // Simple email validation using regex
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null; // Valid
  }

  // Validate phone field
  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone is required';
    }
    if (value.length < 10) {
      return 'Phone must be at least 10 digits';
    }
    return null; // Valid
  }

  // Validate age field
  String? _validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }
    int? age = int.tryParse(value);
    if (age == null) {
      return 'Age must be a number';
    }
    if (age < 1 || age > 120) {
      return 'Please enter a valid age (1-120)';
    }
    return null; // Valid
  }

  // ============ BUILD UI ============

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          // Form key allows validating entire form at once
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== FORM TITLE =====
              Text(
                'Update Your Profile',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              // ===== NAME FIELD =====
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.deepPurple,
                      width: 2,
                    ),
                  ),
                ),
                // Validate when user leaves field
                onChanged: (value) => _formKey.currentState?.validate(),
                // Custom validator function
                validator: _validateName,
              ),

              const SizedBox(height: 16),

              // ===== EMAIL FIELD =====
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'Enter your email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.deepPurple,
                      width: 2,
                    ),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                // Show email keyboard
                onChanged: (value) => _formKey.currentState?.validate(),
                validator: _validateEmail,
              ),

              const SizedBox(height: 16),

              // ===== PHONE FIELD =====
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.deepPurple,
                      width: 2,
                    ),
                  ),
                ),
                keyboardType: TextInputType.phone,
                // Show phone keyboard
                onChanged: (value) => _formKey.currentState?.validate(),
                validator: _validatePhone,
              ),

              const SizedBox(height: 16),

              // ===== AGE FIELD =====
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: 'Age',
                  hintText: 'Enter your age',
                  prefixIcon: const Icon(Icons.cake),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.deepPurple,
                      width: 2,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                // Show number keyboard
                onChanged: (value) => _formKey.currentState?.validate(),
                validator: _validateAge,
              ),

              const SizedBox(height: 32),

              // ===== BUTTONS =====
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _handleSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    disabledBackgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isSubmitting
                      // Show spinner while submitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      // Show text normally
                      : const Text(
                          'Save Changes',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 12),

              // Cancel button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.deepPurple, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

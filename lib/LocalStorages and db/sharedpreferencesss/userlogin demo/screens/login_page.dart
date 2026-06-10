import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// LoginPage is a StatefulWidget because it has mutable state
// State = variables that can change (username input, loading status, etc.)
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  // Creates the mutable state for this widget
  @override
  State<LoginPage> createState() => _LoginPageState();
}

// _LoginPageState holds all the mutable data and logic for LoginPage
class _LoginPageState extends State<LoginPage> {
  // ============ VARIABLES ============
  // TextEditingController manages the username input field
  // Allows us to get the text user types and clear it programmatically
  final TextEditingController _usernameController = TextEditingController();
  
  // TextEditingController manages the password input field
  final TextEditingController _passwordController = TextEditingController();
  
  // SharedPreferences instance - used to save/retrieve data from device storage
  // 'late' means it will be initialized later in initState(), not at creation
  late SharedPreferences _prefs;
  // Track if login is in progress
  // Used to show/hide loading spinner on button
  bool _isLoading = false;

  // ============ LIFECYCLE METHODS ============
  // initState() runs once when the widget is first created
  @override
  void initState() {
    super.initState();
    // Initialize SharedPreferences and check if user already logged in
    _initializePreferences();
  }

  // ============ INITIALIZATION METHOD ============
  // Initialize SharedPreferences - called only once at app startup
  Future<void> _initializePreferences() async {
    try {
      // Get SharedPreferences instance from device storage
      // 'await' pauses here until SharedPreferences is ready
      _prefs = await SharedPreferences.getInstance();
      // Check if user was already logged in previously
      _checkExistingLogin();
    } catch (e) {
      // If initialization fails, show error
      if (mounted) {
        _showErrorSnackBar('Failed to initialize app: $e');
      }
    }
  }

  // Check if username already exists from previous login
  // If yes, navigate directly to home page (skip login)
  void _checkExistingLogin() {
    // Get the saved username from SharedPreferences
    // Key 'username' was used when saving in previous login
    String? savedUsername = _prefs.getString('username');
    // Get the login status flag
    bool isLoggedIn = _prefs.getBool('isLoggedIn') ?? false;
    
    // If both username and login status exist, user was previously logged in
    if (savedUsername != null && savedUsername.isNotEmpty && isLoggedIn) {
      // Navigate to home page immediately (no login screen shown)
      // 'if (mounted)' prevents errors if widget destroyed during async operations
      if (mounted) {
        // pushReplacementNamed removes login page from stack
        // User can't go back to login with back button
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  // ============ LOGIN LOGIC ============

  // Handle login button click - validates input and saves data
  Future<void> _handleLogin() async {
    // ===== INPUT VALIDATION =====
    // Check if username field is empty
    if (_usernameController.text.trim().isEmpty) {
      // trim() removes spaces from start and end
      _showErrorSnackBar('Please enter username');
      return; // Stop execution if validation fails
    }

    // Check if password field is empty
    if (_passwordController.text.isEmpty) {
      _showErrorSnackBar('Please enter password');
      return;
    }

    // ===== START LOADING STATE =====
    // Update UI to show loading spinner
    setState(() {
      _isLoading = true; // Button will show spinner instead of text
    });

    try {
      // ===== OPTIONAL: SIMULATE NETWORK REQUEST =====
      // Wait 1 second to simulate API call (in real app, make actual API request)
      // In production, you'd validate credentials with backend server here
      await Future.delayed(const Duration(seconds: 1));

      // ===== SAVE DATA TO DEVICE STORAGE =====
      
      // SAVE USERNAME
      // Key: 'username' - this identifies the stored data
      // Value: _usernameController.text.trim() - the actual username
      // 'await' waits for save operation to complete
      await _prefs.setString('username', _usernameController.text.trim());
      
      // SAVE LOGIN STATUS
      // Key: 'isLoggedIn' 
      // Value: true - user is now logged in
      await _prefs.setBool('isLoggedIn', true);

      // ===== CLEAR INPUT FIELDS =====
      
      // Clear username field for security (empty the TextController)
      _usernameController.clear();
      
      // Clear password field
      _passwordController.clear();

      // ===== NAVIGATE TO HOME PAGE =====
      
      // Check if widget is still mounted before navigating
      // 'mounted' returns true if widget is still displayed on screen
      if (mounted) {
        // Navigate to home page using named route '/home'
        // pushReplacementNamed removes current page from stack
        Navigator.pushReplacementNamed(context, '/home');
      }
      
    } catch (e) {
      // Handle any errors that occurred during login
      if (mounted) {
        _showErrorSnackBar('Login failed: $e');
      }
    } finally {
      // Always executed, whether login succeeded or failed
      // Stop loading spinner
      if (mounted) {
        setState(() {
          _isLoading = false; // Hide spinner, show button text again
        });
      }
    }
  }

  // ============ UI HELPER METHODS ============

  // Show error message at bottom of screen
  void _showErrorSnackBar(String message) {
    // ScaffoldMessenger displays snackbar (bottom notification)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red, // Red for error
        duration: const Duration(seconds: 2), // Show for 2 seconds
      ),
    );
  }

  // ============ CLEANUP ============

  // dispose() is called when this widget is destroyed
  // Always clean up resources to prevent memory leaks
  @override
  void dispose() {
    // Dispose the username controller - releases resources
    _usernameController.dispose();
    // Dispose the password controller
    _passwordController.dispose();
    // Call parent's dispose method (required)
    super.dispose();
  }

  // ============ BUILD UI ============
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar at the top of screen
      appBar: AppBar(
        title: const Text('Login to App'),
        elevation: 0,
        backgroundColor: const Color(0xFF2E75B6), // Professional blue color
      ),
      
      // Main body of the page
      body: SingleChildScrollView(
        // SingleChildScrollView allows scrolling if content exceeds screen height
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch to fill width
          
          children: [
            // ===== WELCOME TITLE =====
            
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Text(
                'Welcome Back!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E75B6),
                ),
              ),
            ),

            // ===== USERNAME INPUT FIELD =====
            
            TextFormField(
              // Connect this field to username controller
              controller: _usernameController,
              
              // Decoration customizes field appearance
              decoration: InputDecoration(
                labelText: 'Username', // Label shown above field
                hintText: 'Enter your username', // Placeholder text (grayed out)
                prefixIcon: const Icon(Icons.person), // Icon on left side
                
                // Border when field is not focused (not being typed in)
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                
                // Border when field is focused (user typing)
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF2E75B6),
                    width: 2,
                  ),
                ),
              ),
              
              // 'next' button on keyboard moves to next field
              textInputAction: TextInputAction.next,
              
              // When 'next' is pressed, move focus to password field
              onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            ),

            // Vertical space between username and password fields
            const SizedBox(height: 16),

            // ===== PASSWORD INPUT FIELD =====
            
            TextFormField(
              // Connect this field to password controller
              controller: _passwordController,
              
              // obscureText hides password characters as dots/asterisks
              obscureText: true,
              
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock), // Lock icon
                
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xFF2E75B6),
                    width: 2,
                  ),
                ),
              ),
              
              // 'done' button on keyboard when this field is focused
              textInputAction: TextInputAction.done,
              
              // When 'done' is pressed, trigger login
              onFieldSubmitted: (_) => _isLoading ? null : _handleLogin(),
            ),

            // Large space before button
            const SizedBox(height: 30),

            // ===== LOGIN BUTTON =====
            
            SizedBox(
              width: double.infinity, // Button takes full width
              height: 50,
              
              child: ElevatedButton(
                // Disable button while loading (onPressed: null disables it)
                onPressed: _isLoading ? null : _handleLogin,
                
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E75B6), // Button color
                  disabledBackgroundColor: Colors.grey, // Color when disabled
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                
                // Show different content based on loading state
                child: _isLoading
                    // IF LOADING: Show spinner
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    // IF NOT LOADING: Show text
                    : const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

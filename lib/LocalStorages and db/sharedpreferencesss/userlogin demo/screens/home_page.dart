import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// HomePage displays user information and allows logout
// It's a StatefulWidget because it loads data and updates UI
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// _HomePageState holds state variables and logic for HomePage
class _HomePageState extends State<HomePage> {
  // ============ VARIABLES ============

  // SharedPreferences instance for accessing saved data
  // 'late' means initialized later in initState()
  late SharedPreferences _prefs;
  // Store the logged-in username retrieved from storage
  // Nullable (String?) because it might not exist initially
  String? _username;
  // Track if data is being loaded from storage
  // Used to show/hide loading spinner while loading
  bool _isLoading = true;

  // ============ LIFECYCLE METHODS ============
  // initState() runs once when widget first created
  @override
  void initState() {
    super.initState();
    // Load user data from SharedPreferences when page opens
    _loadUserData();
  }

  // ============ DATA LOADING ============

  // Load username from SharedPreferences storage
  Future<void> _loadUserData() async {
    try {
      // Get SharedPreferences instance from device
      // 'await' waits for connection to device storage
      _prefs = await SharedPreferences.getInstance();
      // ===== RETRIEVE USERNAME FROM STORAGE =====

      // getString('username') looks for data with key 'username'
      // We used 'username' key when saving in LoginPage
      // Returns null if key doesn't exist (first login)
      String? savedUsername = _prefs.getString('username');
      // ===== UPDATE UI WITH LOADED DATA =====

      // setState() rebuilds the widget with new data
      setState(() {
        // Store the loaded username
        _username = savedUsername;
        // Stop showing loading spinner
        _isLoading = false;
      });
    } catch (e) {
      // Handle any errors that occur during loading
      if (mounted) {
        // Show error message if something goes wrong
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }

      // Stop loading even if error occurs
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // ============ LOGOUT LOGIC ============

  // Handle logout - remove saved data and return to login
  Future<void> _handleLogout() async {
    try {
      // Show loading state while logging out
      setState(() {
        _isLoading = true;
      });
      // ===== REMOVE DATA FROM STORAGE =====
      // Remove the username from SharedPreferences
      // Key 'username' no longer exists after this
      await _prefs.remove('username');
      // Remove the login status flag
      await _prefs.remove('isLoggedIn');
      // ===== NAVIGATE BACK TO LOGIN =====

      // Check if widget still mounted before navigating
      if (mounted) {
        // Navigate to login page (route '/')
        // pushReplacementNamed removes home page from stack
        // User can't go back to home with back button
        Navigator.pushReplacementNamed(context, '/');
      }
    } catch (e) {
      // Handle errors during logout
      if (mounted) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error logging out: $e'),
            backgroundColor: Colors.red,
          ),
        );

        // Stop loading if error
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // ============ BUILD UI ============

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar at top of screen
      appBar: AppBar(
        title: const Text('Home Page'),
        elevation: 0,
        backgroundColor: const Color(0xFF2E75B6),

        // Add logout button to top-right corner
        actions: [
          // Logout button appears as icon in app bar
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _handleLogout, // Call logout when tapped
            tooltip: 'Logout', // Text shown on long press
          ),
        ],
      ),

      // Main content - show spinner or content based on loading state
      body: _isLoading
          // ===== SHOW LOADING SPINNER =====
          // This displays while data is being loaded from storage
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF2E75B6)),
            )
          // ===== SHOW HOME PAGE CONTENT =====
          // This displays after data finishes loading
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== WELCOME TEXT =====
                  Text(
                    'Welcome to Home Page',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2E75B6),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ===== USERNAME CARD =====
                  Card(
                    elevation: 4, // Shadow depth
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Label
                          const Text(
                            'Logged In As:',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Display username from SharedPreferences
                          // ?? 'Guest' = show 'Guest' if username is null
                          Text(
                            _username ?? 'Guest',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E75B6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: _handleLogout,
                      icon: const Icon(Icons.logout),
                      label: const Text('Logout'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // ============ UI HELPER METHODS ============

  // Build an information tile with icon and text
  // Used to display session information
  Widget _buildInfoTile(String title, String subtitle, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Icon on the left
          Icon(icon, color: const Color(0xFF2E75B6), size: 24),

          const SizedBox(width: 12),

          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title text
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 4),

                // Subtitle text in gray
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

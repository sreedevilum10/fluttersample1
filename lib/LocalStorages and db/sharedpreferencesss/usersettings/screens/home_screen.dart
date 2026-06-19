import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user.dart';
import 'edit_profile_screen.dart';

// HomeScreen displays user profile and settings
// StatefulWidget because it loads and manages user data
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// _HomeScreenState manages the state and logic
class _HomeScreenState extends State<HomeScreen> {
  // ============ VARIABLES ============
  // SharedPreferences instance for data storage
  late SharedPreferences _prefs;
  // Current user data
  User? _user;
  // Track if data is loading
  bool _isLoading = true;
  // Key for storing user data in SharedPreferences
  static const String _userKey = 'user_data';

  // ============ LIFECYCLE ============

  @override
  void initState() {
    super.initState();
    // Load user data when screen opens
    _loadUserData();
  }

  // ============ DATA LOADING ============

  // Load user data from SharedPreferences
  Future<void> _loadUserData() async {
    try {
      // Get SharedPreferences instance
      _prefs = await SharedPreferences.getInstance();
      // Try to get saved user data with key 'user_data'
      String? userJson = _prefs.getString(_userKey);
      // Decode and parse the user data
      User loadedUser;
      if (userJson != null && userJson.isNotEmpty) {
        // User data exists - decode JSON string to Map, then to User object
        Map<String, dynamic> userMap =
                     jsonDecode(userJson);
        loadedUser = User.fromMap(userMap);
      } else {
        // No user data exists - create empty user
        loadedUser = User.empty();
      }
      // Update UI with loaded data
      setState(() {
        _user = loadedUser;
        _isLoading = false;
      });
    } catch (e) {
      // Handle errors during loading
      if (mounted) {
        _showErrorSnackBar('Error loading data: $e');
      }
      setState(() {
        _isLoading = false;
      });
    }
  }
  // ============ DATA SAVING ============
  // Save user data to SharedPreferences
  // This is called after user edits profile
  Future<void> _saveUserData(User user) async {
    try {
      // Convert User object to Map
      Map<String, dynamic> userMap = user.toMap();
      // Convert Map to JSON string
      String userJson = jsonEncode(userMap);
      // Save JSON string to SharedPreferences with key 'user_data'
      await _prefs.setString(_userKey, userJson);
      // Update UI with new user data
      setState(() {
        _user = user;
      });
      // Show success message
      if (mounted) {
        _showSuccessSnackBar('Profile updated successfully!');
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Error saving data: $e');
      }
    }
  }

  // ============ DATA DELETION ============
  // Delete all user data from SharedPreferences
  Future<void> _deleteAllData() async {
    try {
      // Show confirmation dialog
      bool? confirmed = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Delete All Data?'),
            content: const Text('This will erase all saved settings. '
                'This action cannot be undone.'),
            actions: [
              // Cancel button
              TextButton(
                onPressed: () =>
                    Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              // Delete button
              TextButton(
                onPressed: () =>
                    Navigator.pop(context, true),
                child: const Text('Delete',
                    style: TextStyle(color: Colors.red)),
              ),],);},);
      // If user confirmed deletion
      if (confirmed == true) {
        // Remove user data from SharedPreferences
        await _prefs.remove(_userKey);
        // Reset to empty user
        setState(() {
          _user = User.empty();
        });
        if (mounted) {
          _showSuccessSnackBar('All data deleted');
        }}
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Error deleting data: $e');
      }
    }
  }

  // ============ UI HELPERS ============

  // Show success message
  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Show error message
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ============ BUILD UI ============

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Settings Manager'),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        actions: [
          // Menu button - FIXED with proper type specification
          PopupMenuButton<String>(
            onSelected: (String result) {
              // Handle menu selection based on result
              if (result == 'edit') {
                _navigateToEditProfile();
              } else if (result == 'delete') {
                _deleteAllData();
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                // Edit option
                const PopupMenuItem<String>(
                  value: 'edit',
                  child: Text('Edit Profile'),
                ),
                // Divider
                const PopupMenuDivider(),
                // Delete option
                const PopupMenuItem<String>(
                  value: 'delete',
                  child: Text(
                    'Delete All Data',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ];
            },
          ),
        ],
      ),

      body: _isLoading
      // Show spinner while loading
          ? const Center(
        child: CircularProgressIndicator(
          color: Colors.deepPurple,
        ),
      )
      // Show user data
          : _user != null
          ? SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== PROFILE HEADER =====

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [Colors.deepPurple, Colors.purple.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    // Profile avatar
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Text(
                        _user!.name.isNotEmpty
                            ? _user!.name[0].toUpperCase()
                            : 'U',
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // User name
                    Text(
                      _user!.name.isNotEmpty ? _user!.name : 'No Name Set',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // User email
                    Text(
                      _user!.email.isNotEmpty ? _user!.email : 'No Email',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ===== PROFILE INFORMATION =====

            Text(
              'Profile Information',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // Name info
            _buildInfoTile(
              icon: Icons.person,
              label: 'Full Name',
              value: _user!.name.isNotEmpty ? _user!.name : 'Not set',
            ),

            // Email info
            _buildInfoTile(
              icon: Icons.email,
              label: 'Email',
              value: _user!.email.isNotEmpty ? _user!.email : 'Not set',
            ),

            // Phone info
            _buildInfoTile(
              icon: Icons.phone,
              label: 'Phone',
              value: _user!.phone.isNotEmpty ? _user!.phone : 'Not set',
            ),

            // Age info
            _buildInfoTile(
              icon: Icons.cake,
              label: 'Age',
              value: _user!.age > 0 ? '${_user!.age} years' : 'Not set',
            ),

            const SizedBox(height: 24),


            // ===== EDIT BUTTON =====

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _navigateToEditProfile,
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ===== SHOW DATA BUTTON =====

            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: () {
                  // Show raw data for debugging
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Saved Data: ${_user.toString()}'),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                },
                icon: const Icon(Icons.info),
                label: const Text('Show Raw Data'),
              ),
            ),
          ],
        ),
      )
          : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person_outline,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            const Text(
              'No Profile Data',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Tap Edit to create your profile',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _navigateToEditProfile,
              icon: const Icon(Icons.edit),
              label: const Text('Create Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============ UI WIDGET BUILDERS ============

  // Build an info tile showing label and value
  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Icon
          Icon(icon, color: Colors.deepPurple, size: 24),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Build a toggle switch tile
  Widget _buildToggleTile({
    required IconData icon,
    required String label,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Icon
          Icon(icon, color: Colors.deepPurple, size: 24),
          const SizedBox(width: 16),
          // Label
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Toggle switch
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.deepPurple,
          ),
        ],
      ),
    );
  }

  // Navigate to edit profile screen
  void _navigateToEditProfile() async {
    // Navigate and wait for result
    final updatedUser = await Navigator.push<User>(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(user: _user ?? User.empty()),
      ),
    );

    // If user returned with updated data, save it
    if (updatedUser != null) {
      _saveUserData(updatedUser);
    }
  }
}

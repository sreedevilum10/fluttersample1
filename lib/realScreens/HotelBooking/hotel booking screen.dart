import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel Booking App',
      theme: ThemeData(
        primaryColor: Color(0xFF1e88e5),
        useMaterial3: true,
      ),
      home: HotelBookingHome(),
    );
  }
}

class HotelBookingHome extends StatefulWidget {
  @override
  State<HotelBookingHome> createState() => _HotelBookingHomeState();
}

class _HotelBookingHomeState extends State<HotelBookingHome> {
  // Form Controllers
  final _cityController = TextEditingController();
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  TimeOfDay? _checkInTime;

  // Room Selection
  String _selectedRoom = 'deluxe';

  // Guest Type Selection
  String _selectedGuestType = 'business';

  // Guests Dropdown
  String _numberOfGuests = '1 Guest';

  // Amenities Checkboxes
  bool _pool = true;
  bool _restaurant = true;
  bool _gym = false;
  bool _wifi = true;
  bool _parking = false;

  // Price Slider
  double _priceRange = 250;

  // Preferences Toggles
  bool _nonSmoking = true;
  bool _breakfast = false;
  bool _earlyCheckIn = true;

  // Special Requests
  final _requestsController = TextEditingController();

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _checkInDate = DateTime.now();
    _checkOutDate = DateTime.now().add(Duration(days: 5));
    _checkInTime = TimeOfDay(hour: 15, minute: 0);
    _cityController.text = 'New York';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildSearchPage(),
          _buildSavedPage(),
          _buildBookingsPage(),
          _buildProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // ============ SEARCH PAGE ============
  Widget _buildSearchPage() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1e88e5), Color(0xFF1565c0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: EdgeInsets.all(20),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Text(
                    '🏨 Hotel Booking',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Book your perfect stay',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ===== SEARCH SECTION =====
                _buildCard(
                  title: 'Search Hotels',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // City Input
                      _buildLabel('City *'),
                      TextField(
                        controller: _cityController,
                        decoration: _inputDecoration('Enter city name'),
                      ),
                      SizedBox(height: 12),

                      // Check-in Date
                      _buildLabel('Check-in Date *'),
                      ElevatedButton.icon(
                        onPressed: _selectCheckInDate,
                        icon: Icon(Icons.calendar_today, size: 18),
                        label: Text(
                          _checkInDate != null
                              ? DateFormat('MMM dd, yyyy').format(_checkInDate!)
                              : 'Select date',
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                      SizedBox(height: 12),

                      // Check-out Date
                      _buildLabel('Check-out Date *'),
                      ElevatedButton.icon(
                        onPressed: _selectCheckOutDate,
                        icon: Icon(Icons.calendar_today, size: 18),
                        label: Text(
                          _checkOutDate != null
                              ? DateFormat('MMM dd, yyyy')
                              .format(_checkOutDate!)
                              : 'Select date',
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                      SizedBox(height: 12),

                      // Check-in Time
                      _buildLabel('Preferred Check-in Time'),
                      ElevatedButton.icon(
                        onPressed: _selectCheckInTime,
                        icon: Icon(Icons.access_time, size: 18),
                        label: Text(
                          _checkInTime?.format(context) ?? 'Select time',
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                // ===== ROOM SELECTION =====
                _buildCard(
                  title: 'Room Type',
                  child: Column(
                    children: [
                      _buildRadioTile(
                        'Deluxe Room - \$120/night',
                        'deluxe',
                        _selectedRoom,
                            (value) =>
                            setState(() => _selectedRoom = value ?? ''),
                      ),
                      _buildRadioTile(
                        'Premium Room - \$180/night',
                        'premium',
                        _selectedRoom,
                            (value) =>
                            setState(() => _selectedRoom = value ?? ''),
                      ),
                      _buildRadioTile(
                        'Suite - \$280/night',
                        'suite',
                        _selectedRoom,
                            (value) =>
                            setState(() => _selectedRoom = value ?? ''),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                // ===== GUEST TYPE =====
                _buildCard(
                  title: 'Guest Type',
                  child: Column(
                    children: [
                      _buildRadioTile(
                        'Business',
                        'business',
                        _selectedGuestType,
                            (value) => setState(
                                () => _selectedGuestType = value ?? ''),
                      ),
                      _buildRadioTile(
                        'Leisure',
                        'leisure',
                        _selectedGuestType,
                            (value) => setState(
                                () => _selectedGuestType = value ?? ''),
                      ),
                      _buildRadioTile(
                        'Family',
                        'family',
                        _selectedGuestType,
                            (value) => setState(
                                () => _selectedGuestType = value ?? ''),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                // ===== NUMBER OF GUESTS =====
                _buildCard(
                  title: 'Number of Guests',
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _numberOfGuests,
                    items: [
                      '1 Guest',
                      '2 Guests',
                      '3 Guests',
                      '4 Guests',
                      '5+ Guests'
                    ]
                        .map(
                          (e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      ),
                    )
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _numberOfGuests = value ?? ''),
                  ),
                ),
                SizedBox(height: 16),

                // ===== AMENITIES =====
                _buildCard(
                  title: 'Amenities',
                  child: Column(
                    children: [
                      _buildCheckboxTile(
                        '🏊 Swimming Pool',
                        _pool,
                            (value) => setState(() => _pool = value ?? false),
                      ),
                      _buildCheckboxTile(
                        '🍽️ Restaurant',
                        _restaurant,
                            (value) =>
                            setState(() => _restaurant = value ?? false),
                      ),
                      _buildCheckboxTile(
                        '🏋️ Gym',
                        _gym,
                            (value) => setState(() => _gym = value ?? false),
                      ),
                      _buildCheckboxTile(
                        '📶 Free WiFi',
                        _wifi,
                            (value) => setState(() => _wifi = value ?? false),
                      ),
                      _buildCheckboxTile(
                        '🚗 Parking',
                        _parking,
                            (value) =>
                            setState(() => _parking = value ?? false),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                // ===== PRICE RANGE SLIDER =====
                _buildCard(
                  title: 'Price Range',
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Max Price',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            '\$${_priceRange.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1e88e5),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Slider(
                        value: _priceRange,
                        min: 0,
                        max: 500,
                        divisions: 50,
                        label:
                        '\$${_priceRange.toStringAsFixed(0)}',
                        onChanged: (value) =>
                            setState(() => _priceRange = value),
                      ),
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$0',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '\$500',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                // ===== PREFERENCES TOGGLES =====
                _buildCard(
                  title: 'Preferences',
                  child: Column(
                    children: [
                      _buildSwitchTile(
                        'Non-smoking Room',
                        _nonSmoking,
                            (value) =>
                            setState(() => _nonSmoking = value),
                      ),
                      Divider(height: 1),
                      _buildSwitchTile(
                        'Breakfast Included',
                        _breakfast,
                            (value) =>
                            setState(() => _breakfast = value),
                      ),
                      Divider(height: 1),
                      _buildSwitchTile(
                        'Early Check-in',
                        _earlyCheckIn,
                            (value) =>
                            setState(() => _earlyCheckIn = value),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                // ===== SPECIAL REQUESTS =====
                _buildCard(
                  title: 'Special Requests',
                  child: TextField(
                    controller: _requestsController,
                    maxLines: 4,
                    decoration: _inputDecoration(
                      'Let us know any special requirements...',
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // ===== ACTION BUTTONS =====
                Row(
                  children: [
                    // Text Button (Clear)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _clearForm,
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text('Clear'),
                      ),
                    ),
                    SizedBox(width: 10),
                    // Elevated Button (Search)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _searchHotels,
                        icon: Icon(Icons.search),
                        label: Text('Search'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: Color(0xFF1e88e5),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============ SAVED PAGE ============
  Widget _buildSavedPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Hotels'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No saved hotels yet',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () => setState(() => _selectedIndex = 0),
              child: Text('Start exploring'),
            ),
          ],
        ),
      ),
    );
  }

  // ============ BOOKINGS PAGE ============
  Widget _buildBookingsPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bookings'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_month, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No active bookings',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () => setState(() => _selectedIndex = 0),
              child: Text('Book a hotel'),
            ),
          ],
        ),
      ),
    );
  }

  // ============ PROFILE PAGE ============
  Widget _buildProfilePage() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Header
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFF1e88e5),
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'john.doe@email.com',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),

            // Profile Options
            _buildProfileOption(Icons.person_outline, 'Personal Information'),
            _buildProfileOption(Icons.payment, 'Payment Methods'),
            _buildProfileOption(Icons.notifications, 'Notifications'),
            _buildProfileOption(Icons.security, 'Security'),
            _buildProfileOption(Icons.help_outline, 'Help & Support'),
            _buildProfileOption(Icons.logout, 'Logout'),
          ],
        ),
      ),
    );
  }

  // ============ HELPER WIDGETS ============

  Widget _buildCard({required String title, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFe0e0e0)),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }

  Widget _buildRadioTile(String label, String value, String groupValue,
      Function(String?) onChanged) {
    return RadioListTile<String>(
      title: Text(
        label,
        style: TextStyle(fontSize: 13),
      ),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      dense: true,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildCheckboxTile(String label, bool value, Function(bool?) onChanged) {
    return CheckboxListTile(
      title: Text(
        label,
        style: TextStyle(fontSize: 13),
      ),
      value: value,
      onChanged: onChanged,
      dense: true,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget _buildSwitchTile(String label, bool value, Function(bool) onChanged) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 13),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Color(0xFF1e88e5),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String label) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          backgroundColor: Colors.grey[100],
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
    );
  }

  // ============ FUNCTIONS ============

  Future<void> _selectCheckInDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _checkInDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != _checkInDate) {
      setState(() => _checkInDate = picked);
    }
  }

  Future<void> _selectCheckOutDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _checkOutDate ?? DateTime.now().add(Duration(days: 1)),
      firstDate: _checkInDate ?? DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != _checkOutDate) {
      setState(() => _checkOutDate = picked);
    }
  }

  Future<void> _selectCheckInTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _checkInTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _checkInTime) {
      setState(() => _checkInTime = picked);
    }
  }

  void _clearForm() {
    setState(() {
      _cityController.clear();
      _checkInDate = DateTime.now();
      _checkOutDate = DateTime.now().add(Duration(days: 5));
      _checkInTime = TimeOfDay(hour: 15, minute: 0);
      _selectedRoom = 'deluxe';
      _selectedGuestType = 'business';
      _numberOfGuests = '1 Guest';
      _pool = true;
      _restaurant = true;
      _gym = false;
      _wifi = true;
      _parking = false;
      _priceRange = 250;
      _nonSmoking = true;
      _breakfast = false;
      _earlyCheckIn = true;
      _requestsController.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Form cleared'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _searchHotels() {
    // Validate form
    if (_cityController.text.isEmpty) {
      _showSnackBar('Please enter a city');
      return;
    }
    if (_checkInDate == null || _checkOutDate == null) {
      _showSnackBar('Please select dates');
      return;
    }

    // Show results
    _showSnackBar(
      'Found 42 hotels in ${_cityController.text}\n'
          'Check-in: ${DateFormat('MMM dd').format(_checkInDate!)}\n'
          'Room: ${_selectedRoom.toUpperCase()}\n'
          'Guests: $_numberOfGuests\n'
          'Max Price: \$${_priceRange.toStringAsFixed(0)}',
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _cityController.dispose();
    _requestsController.dispose();
    super.dispose();
  }
}
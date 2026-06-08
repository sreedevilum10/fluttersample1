// ==================== SALON BOOKING APP - MVC ARCHITECTURE ====================
// Complete app demonstrating proper MVC pattern in Flutter

import 'package:flutter/material.dart';

// ==================== MODELS ====================

class Service {
  final int id;
  final String name;
  final String description;
  final double price;
  final int durationMinutes;
  final String icon;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.durationMinutes,
    required this.icon,
  });
}

class Stylist {
  final int id;
  final String name;
  final String specialization;
  final double rating;
  final int reviews;
  final String avatar;
  final bool isAvailable;

  Stylist({
    required this.id,
    required this.name,
    required this.specialization,
    required this.rating,
    required this.reviews,
    required this.avatar,
    required this.isAvailable,
  });
}

class TimeSlot {
  final String time;
  final bool isAvailable;

  TimeSlot({
    required this.time,
    required this.isAvailable,
  });
}

class Booking {
  final String id;
  final Service service;
  final Stylist stylist;
  final DateTime dateTime;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final double totalPrice;
  final String status; // pending, confirmed, completed, cancelled

  Booking({
    required this.id,
    required this.service,
    required this.stylist,
    required this.dateTime,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhone,
    required this.totalPrice,
    required this.status,
  });
}

// ==================== CONTROLLERS ====================

class SalonController {
  // Data
  List<Service> _services = [];
  List<Stylist> _stylists = [];
  List<Booking> _bookings = [];

  // Getters
  List<Service> get services => _services;
  List<Stylist> get stylists => _stylists;
  List<Booking> get bookings => _bookings;

  // Constructor - Initialize with mock data
  SalonController() {
    _initializeData();
  }

  void _initializeData() {
    // Initialize services
    _services = [
      Service(
        id: 1,
        name: 'Hair Cut & Style',
        description: 'Professional haircut with styling',
        price: 45,
        durationMinutes: 60,
        icon: '💇‍♀️',
      ),
      Service(
        id: 2,
        name: 'Hair Coloring',
        description: 'Professional hair coloring service',
        price: 75,
        durationMinutes: 90,
        icon: '🎨',
      ),
      Service(
        id: 3,
        name: 'Manicure & Pedicure',
        description: 'Complete nail care and polish',
        price: 35,
        durationMinutes: 45,
        icon: '💅',
      ),
      Service(
        id: 4,
        name: 'Facial Treatment',
        description: 'Rejuvenating facial care',
        price: 55,
        durationMinutes: 50,
        icon: '💆‍♀️',
      ),
      Service(
        id: 5,
        name: 'Hair Spa',
        description: 'Relaxing hair spa treatment',
        price: 65,
        durationMinutes: 75,
        icon: '🌊',
      ),
      Service(
        id: 6,
        name: 'Highlights',
        description: 'Professional hair highlights',
        price: 95,
        durationMinutes: 120,
        icon: '✨',
      ),
    ];

    // Initialize stylists
    _stylists = [
      Stylist(
        id: 1,
        name: 'Sarah Johnson',
        specialization: 'Senior Hair Stylist',
        rating: 4.9,
        reviews: 180,
        avatar: '👩‍🦱',
        isAvailable: true,
      ),
      Stylist(
        id: 2,
        name: 'Emma Williams',
        specialization: 'Nail & Makeup Specialist',
        rating: 4.8,
        reviews: 156,
        avatar: '👩‍🦰',
        isAvailable: true,
      ),
      Stylist(
        id: 3,
        name: 'Lisa Chen',
        specialization: 'Massage & Spa Therapist',
        rating: 4.9,
        reviews: 192,
        avatar: '👩',
        isAvailable: true,
      ),
      Stylist(
        id: 4,
        name: 'Maria Garcia',
        specialization: 'Facial & Skincare Expert',
        rating: 4.7,
        reviews: 143,
        avatar: '👩‍🦳',
        isAvailable: false,
      ),
    ];
  }

  // Service methods
  List<Service> getServices() => _services;

  Service? getServiceById(int id) {
    try {
      return _services.firstWhere((s) => s.id == id);
    } catch (e) {
      return null;
    }
  }

  // Stylist methods
  List<Stylist> getStylists() => _stylists;

  Stylist? getStylistById(int id) {
    try {
      return _stylists.firstWhere((s) => s.id == id);
    } catch (e) {
      return null;
    }
  }

  // Time slot methods
  List<TimeSlot> getAvailableTimeSlots(DateTime date) {
    return [
      TimeSlot(time: '10:00 AM', isAvailable: true),
      TimeSlot(time: '11:30 AM', isAvailable: true),
      TimeSlot(time: '02:00 PM', isAvailable: true),
      TimeSlot(time: '03:30 PM', isAvailable: false),
      TimeSlot(time: '04:30 PM', isAvailable: true),
      TimeSlot(time: '06:00 PM', isAvailable: true),
    ];
  }

  // Booking methods
  bool createBooking({
    required Service service,
    required Stylist stylist,
    required DateTime dateTime,
    required String customerName,
    required String customerEmail,
    required String customerPhone,
  }) {
    try {
      final booking = Booking(
        id: 'BOOK${DateTime.now().millisecondsSinceEpoch}',
        service: service,
        stylist: stylist,
        dateTime: dateTime,
        customerName: customerName,
        customerEmail: customerEmail,
        customerPhone: customerPhone,
        totalPrice: service.price,
        status: 'confirmed',
      );

      _bookings.add(booking);
      return true;
    } catch (e) {
      return false;
    }
  }

  List<Booking> getCustomerBookings(String email) {
    return _bookings.where((b) => b.customerEmail == email).toList();
  }

  bool cancelBooking(String bookingId) {
    try {
      final booking = _bookings.firstWhere((b) => b.id == bookingId);
      final index = _bookings.indexOf(booking);
      _bookings[index] = Booking(
        id: booking.id,
        service: booking.service,
        stylist: booking.stylist,
        dateTime: booking.dateTime,
        customerName: booking.customerName,
        customerEmail: booking.customerEmail,
        customerPhone: booking.customerPhone,
        totalPrice: booking.totalPrice,
        status: 'cancelled',
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}

// ==================== MAIN APP ====================

void main() {
  runApp(const SalonBookingApp());
}

class SalonBookingApp extends StatelessWidget {
  const SalonBookingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salon Booking',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9C27B0),
        ),
      ),
      home: SalonHomeScreen(controller: SalonController()),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ==================== VIEWS (SCREENS) ====================

class SalonHomeScreen extends StatefulWidget {
  final SalonController controller;

  const SalonHomeScreen({Key? key, required this.controller}) : super(key: key);

  @override
  State<SalonHomeScreen> createState() => _SalonHomeScreenState();
}

class _SalonHomeScreenState extends State<SalonHomeScreen> {
  int _currentIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeView(controller: widget.controller),
      ServicesView(controller: widget.controller),
      StylistsView(controller: widget.controller),
      BookingView(controller: widget.controller),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('✨ Glamour Salon'),
        centerTitle: true,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.spa), label: 'Services'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Stylists'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Book'),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

// ==================== HOME VIEW ====================

class HomeView extends StatelessWidget {
  final SalonController controller;

  const HomeView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            color: const Color(0xFF9C27B0),
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Premium Beauty Services',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search services...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Featured Services Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Featured Services',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.services.take(3).length,
                  itemBuilder: (context, index) {
                    final service = controller.services[index];
                    return _buildServiceCard(context, service);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, Service service) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(service.icon, style: const TextStyle(fontSize: 40)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        service.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${service.durationMinutes} min',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${service.price.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF9C27B0),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () => _navigateToBooking(context, service),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDE88EC),
                  ),
                  child: const Text('Book Now'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToBooking(BuildContext context, Service service) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${service.name} selected. Go to Book tab.')),
    );
  }
}

// ==================== SERVICES VIEW ====================

class ServicesView extends StatelessWidget {
  final SalonController controller;

  const ServicesView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'All Services',
            style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: controller.services.length,
            itemBuilder: (context, index) {
              final service = controller.services[index];
              return _buildServiceGridItem(context, service);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceGridItem(BuildContext context, Service service) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFB6C1), Color(0xFFFF69B4)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(service.icon,
                    style: const TextStyle(
                        fontSize: 40)),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              service.name,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 13),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              '\$${service.price.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9C27B0),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC17DF4),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                child: const Text(
                  'Book',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== STYLISTS VIEW ====================

class StylistsView extends StatelessWidget {
  final SalonController controller;

  const StylistsView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Our Expert Stylists',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.stylists.length,
            itemBuilder: (context, index) {
              final stylist = controller.stylists[index];
              return _buildStylistCard(context, stylist);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStylistCard(BuildContext context, Stylist stylist) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFB6C1), Color(0xFFFF69B4)],
                ),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: Text(stylist.avatar, style: const TextStyle(fontSize: 40)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stylist.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    stylist.specialization,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        '${stylist.rating}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${stylist.reviews})',
                        style: const TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: stylist.isAvailable
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          stylist.isAvailable ? 'Available' : 'Busy',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: stylist.isAvailable
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== BOOKING VIEW ====================

class BookingView extends StatefulWidget {
  final SalonController controller;

  const BookingView({Key? key, required this.controller}) : super(key: key);

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  Service? _selectedService;
  Stylist? _selectedStylist;
  DateTime? _selectedDate;
  String? _selectedTime;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Select Service
          _buildSectionTitle('1. Select Service'),
          _buildDropdown(
            label: 'Service',
            value: _selectedService?.name,
            items: widget.controller.services
                .map((s) => DropdownMenuItem(
              value: s,
              child: Text(s.name),
            ))
                .toList(),
            onChanged: (value) => setState(() => _selectedService = value),
          ),
          const SizedBox(height: 24),

          // Select Stylist
          _buildSectionTitle('2. Select Stylist'),
          _buildDropdown(
            label: 'Stylist',
            value: _selectedStylist?.name,
            items: widget.controller.stylists
                .where((s) => s.isAvailable)
                .map((s) => DropdownMenuItem(
              value: s,
              child: Text('${s.name} (${s.rating}⭐)'),
            ))
                .toList(),
            onChanged: (value) => setState(() => _selectedStylist = value),
          ),
          const SizedBox(height: 24),

          // Select Date
          _buildSectionTitle('3. Select Date'),
          TextField(
            readOnly: true,
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 30)),
              );
              if (date != null) {
                setState(() => _selectedDate = date);
              }
            },
            decoration: InputDecoration(
              labelText: 'Date',
              hintText: _selectedDate != null
                  ? '${_selectedDate?.day}/${_selectedDate?.month}/${_selectedDate?.year}'
                  : 'Select a date',
              prefixIcon: const Icon(Icons.calendar_month),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Select Time
          if (_selectedDate != null) ...[
            _buildSectionTitle('4. Select Time'),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount:
              widget.controller.getAvailableTimeSlots(_selectedDate!).length,
              itemBuilder: (context, index) {
                final slot = widget.controller
                    .getAvailableTimeSlots(_selectedDate!)[index];
                final isSelected = _selectedTime == slot.time;

                return GestureDetector(
                  onTap: slot.isAvailable
                      ? () => setState(() => _selectedTime = slot.time)
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF9C27B0)
                          : slot.isAvailable
                          ? Colors.white
                          : Colors.grey.shade100,
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF9C27B0)
                            : Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        slot.time,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
          ],

          // Personal Details
          _buildSectionTitle('5. Your Details'),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Full Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Booking Summary
          if (_selectedService != null &&
              _selectedStylist != null &&
              _selectedDate != null &&
              _selectedTime != null) ...[
            _buildBookingSummary(),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isFormValid() ? _confirmBooking : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9C27B0),
                ),
                child: const Text(
                  'Confirm Booking',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required String? value,
    required List<DropdownMenuItem<T>> items,
    required Function(T?) onChanged,
  }) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      items: items,
      onChanged: onChanged,
    );
  }

  Widget _buildBookingSummary() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Booking Summary',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSummaryRow('Service:', _selectedService!.name),
            _buildSummaryRow('Stylist:', _selectedStylist!.name),
            _buildSummaryRow(
              'Date:',
              '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
            ),
            _buildSummaryRow('Time:', _selectedTime!),
            _buildSummaryRow(
              'Duration:',
              '${_selectedService!.durationMinutes} minutes',
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Price:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${_selectedService!.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF9C27B0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  bool _isFormValid() {
    return _selectedService != null &&
        _selectedStylist != null &&
        _selectedDate != null &&
        _selectedTime != null &&
        _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty;
  }

  void _confirmBooking() {
    final success = widget.controller.createBooking(
      service: _selectedService!,
      stylist: _selectedStylist!,
      dateTime: DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
      ),
      customerName: _nameController.text,
      customerEmail: _emailController.text,
      customerPhone: _phoneController.text,
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✓ Booking confirmed! Check your email for details.'),
          backgroundColor: Colors.green,
        ),
      );
      _resetForm();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: Booking failed. Try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _resetForm() {
    setState(() {
      _selectedService = null;
      _selectedStylist = null;
      _selectedDate = null;
      _selectedTime = null;
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
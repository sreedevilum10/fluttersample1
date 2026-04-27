import 'package:flutter/material.dart';

void main() {
  runApp(const HotelBookingApp());
}

class HotelBookingApp extends StatelessWidget {
  const HotelBookingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel Booking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HotelListScreen(),
        '/hotel-details': (context) => const HotelDetailsScreen(),
        '/booking': (context) => const BookingScreen(),
      },
    );
  }
}

// ==================== DATA MODELS ====================

class Hotel {
  final int id;
  final String name;
  final String location;
  final String image;
  final double rating;
  final int reviews;
  final double pricePerNight;
  final String description;
  final List<String> amenities;
  final int rooms;
  final int beds;

  Hotel({
    required this.id,
    required this.name,
    required this.location,
    required this.image,
    required this.rating,
    required this.reviews,
    required this.pricePerNight,
    required this.description,
    required this.amenities,
    required this.rooms,
    required this.beds,
  });
}

// ==================== HOTEL LIST SCREEN ====================

class HotelListScreen extends StatefulWidget {
  const HotelListScreen({Key? key}) : super(key: key);

  @override
  State<HotelListScreen> createState() => _HotelListScreenState();
}

class _HotelListScreenState extends State<HotelListScreen> {
  // Sample hotel data
  final List<Hotel> hotels = [
    Hotel(
      id: 1,
      name: 'Luxury Palace Hotel',
      location: 'Downtown, New York',
      image: '🏨',
      rating: 4.8,
      reviews: 324,
      pricePerNight: 299,
      description: 'Experience luxury at its finest with world-class amenities.',
      amenities: ['WiFi', 'Pool', 'Gym', 'Restaurant', 'Spa'],
      rooms: 150,
      beds: 300,
    ),
    Hotel(
      id: 2,
      name: 'Business Inn',
      location: 'Financial District',
      image: '🏢',
      rating: 4.5,
      reviews: 189,
      pricePerNight: 179,
      description: 'Perfect for business travelers with modern facilities.',
      amenities: ['WiFi', 'Business Center', 'Conference Rooms'],
      rooms: 80,
      beds: 120,
    ),
    Hotel(
      id: 3,
      name: 'Beachfront Resort',
      location: 'Coastal Area',
      image: '🏝️',
      rating: 4.7,
      reviews: 456,
      pricePerNight: 349,
      description: 'Enjoy stunning ocean views and pristine beaches.',
      amenities: ['Beach Access', 'Pool', 'Water Sports', 'Bar', 'Restaurant'],
      rooms: 120,
      beds: 250,
    ),
    Hotel(
      id: 4,
      name: 'Budget Stay Hotel',
      location: 'Suburb Area',
      image: '🏠',
      rating: 4.2,
      reviews: 234,
      pricePerNight: 89,
      description: 'Affordable accommodation without compromising comfort.',
      amenities: ['WiFi', 'Parking', 'Restaurant'],
      rooms: 60,
      beds: 100,
    ),
    Hotel(
      id: 5,
      name: 'Mountain Lodge',
      location: 'Hill Station',
      image: '⛰️',
      rating: 4.6,
      reviews: 178,
      pricePerNight: 199,
      description: 'Serene mountain views and peaceful environment.',
      amenities: ['Hiking', 'Bonfire', 'Restaurant', 'Spa'],
      rooms: 45,
      beds: 80,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Booking'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          return HotelListTile(
            hotel: hotels[index],
            onTap: () {
              // Method 1: Using Named Routes with arguments
              Navigator.pushNamed(
                context,
                '/hotel-details',
                arguments: hotels[index],
              );
            },
          );
        },
      ),
    );
  }
}

// ==================== HOTEL LIST TILE WIDGET ====================

class HotelListTile extends StatelessWidget {
  final Hotel hotel;
  final VoidCallback onTap;

  const HotelListTile({
    Key? key,
    required this.hotel,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        // Leading: Hotel image/emoji
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.blueAccent.withOpacity(0.2),
          ),
          child: Center(
            child: Text(
              hotel.image,
              style: const TextStyle(fontSize: 32),
            ),
          ),
        ),
        // Title: Hotel name
        title: Text(
          hotel.name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Subtitle: Location and rating
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(hotel.location),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.star, size: 14, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  '${hotel.rating} (${hotel.reviews} reviews)',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        // Trailing: Price per night
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${hotel.pricePerNight}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const Text(
              'per night',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

// ==================== HOTEL DETAILS SCREEN ====================

class HotelDetailsScreen extends StatefulWidget {
  const HotelDetailsScreen({Key? key}) : super(key: key);

  @override
  State<HotelDetailsScreen> createState() => _HotelDetailsScreenState();
}

class _HotelDetailsScreenState extends State<HotelDetailsScreen> {
  late Hotel hotel;
  int nights = 1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Receive data passed from HotelListScreen
    hotel = ModalRoute.of(context)!.settings.arguments as Hotel;
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = hotel.pricePerNight * nights;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Details'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Method 2: Using Pop to go back
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hotel Image/Icon
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.blueAccent.withOpacity(0.2),
              child: Center(
                child: Text(
                  hotel.image,
                  style: const TextStyle(fontSize: 80),
                ),
              ),
            ),
            // Hotel Info Card
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              hotel.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    size: 16, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(hotel.location),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star,
                                size: 16, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              '${hotel.rating}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Description
                  Text(
                    'About',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(hotel.description),
                  const SizedBox(height: 16),

                  // Amenities using DataTable-like layout
                  Text(
                    'Amenities',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: hotel.amenities.map((amenity) {
                      return Chip(
                        label: Text(amenity),
                        backgroundColor: Colors.blueAccent.withOpacity(0.2),
                        labelStyle: const TextStyle(color: Colors.blueAccent),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // Rooms Info Table
                  Text(
                    'Room Information',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('Item')),
                      DataColumn(label: Text('Count')),
                    ],
                    rows: [
                      DataRow(cells: [
                        const DataCell(Text('Total Rooms')),
                        DataCell(Text(hotel.rooms.toString())),
                      ]),
                      DataRow(cells: [
                        const DataCell(Text('Total Beds')),
                        DataCell(Text(hotel.beds.toString())),
                      ]),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Night Selection
                  Text(
                    'Select Nights',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        onPressed: nights > 1
                            ? () {
                          setState(() => nights--);
                        }
                            : null,
                        icon: const Icon(Icons.remove),
                        color: Colors.blueAccent,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '$nights Night${nights > 1 ? 's' : ''}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() => nights++);
                        },
                        icon: const Icon(Icons.add),
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Price Summary
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Total Price',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              '\$${totalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Method 3: Push to booking screen with data
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingConfirmScreen(
                                  hotel: hotel,
                                  nights: nights,
                                  totalPrice: totalPrice,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.check),
                          label: const Text('Book Now'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
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

// ==================== BOOKING CONFIRMATION SCREEN ====================

class BookingConfirmScreen extends StatelessWidget {
  final Hotel hotel;
  final int nights;
  final double totalPrice;

  const BookingConfirmScreen({
    Key? key,
    required this.hotel,
    required this.nights,
    required this.totalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmation'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Success Icon
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Center(
                  child: Icon(
                    Icons.check,
                    size: 40,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Confirmation Title
            const Center(
              child: Text(
                'Booking Confirmed!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Booking Details Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          hotel.image,
                          style: const TextStyle(fontSize: 32),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hotel.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                hotel.location,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    _buildDetailRow('Nights:', '$nights Night${nights > 1 ? 's' : ''}'),
                    const SizedBox(height: 12),
                    _buildDetailRow('Price per Night:', '\$${hotel.pricePerNight}'),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      'Total Amount:',
                      '\$${totalPrice.toStringAsFixed(2)}',
                      isBold: true,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Navigate back to hotel list
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/',
                            (route) => false,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('Continue Shopping'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/booking');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('View Booking'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isBold ? Colors.blueAccent : Colors.black,
          ),
        ),
      ],
    );
  }
}

// ==================== BOOKING SCREEN ====================

class BookingScreen extends StatelessWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.book_online,
              size: 64,
              color: Colors.blueAccent.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'No active bookings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Book a hotel to see your reservations',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Navigate back to hotel list
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                      (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text('Browse Hotels'),
            ),
          ],
        ),
      ),
    );
  }
}
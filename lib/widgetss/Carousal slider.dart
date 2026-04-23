import 'package:flutter/material.dart';

void main() {
  runApp(const CarouselSliderApp());
}

class CarouselSliderApp extends StatelessWidget {
  const CarouselSliderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carousel Slider Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CarouselSliderScreen(),
    );
  }
}

// ==================== CAROUSEL MODEL ====================

class CarouselItem {
  final int id;
  final String title;
  final String subtitle;
  final String image;
  final Color color;

  CarouselItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.color,
  });
}

// ==================== CAROUSEL SLIDER SCREEN ====================

class CarouselSliderScreen extends StatefulWidget {
  const CarouselSliderScreen({Key? key}) : super(key: key);

  @override
  State<CarouselSliderScreen> createState() => _CarouselSliderScreenState();
}

class _CarouselSliderScreenState extends State<CarouselSliderScreen> {
  // Carousel items
  late List<CarouselItem> items;

  // Carousel state
  late PageController _pageController;
  int _currentIndex = 0;
  late int _autoPlayIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeCarousel();
    _pageController = PageController(initialPage: 0);
  }

  void _initializeCarousel() {
    items = [
      CarouselItem(
        id: 1,
        title: 'Stunning Landscapes',
        subtitle: 'Discover beautiful mountain views',
        image: '🏔️',
        color: Colors.blue,
      ),
      CarouselItem(
        id: 2,
        title: 'Tropical Paradise',
        subtitle: 'Relax on pristine beaches',
        image: '🏖️',
        color: Colors.orange,
      ),
      CarouselItem(
        id: 3,
        title: 'Urban Exploration',
        subtitle: 'Explore vibrant city life',
        image: '🌆',
        color: Colors.purple,
      ),
      CarouselItem(
        id: 4,
        title: 'Nature Adventure',
        subtitle: 'Experience wildlife safari',
        image: '🦁',
        color: Colors.green,
      ),
      CarouselItem(
        id: 5,
        title: 'Snowy Wonderland',
        subtitle: 'Winter sports and activities',
        image: '❄️',
        color: Colors.cyan,
      ),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // ==================== MANUAL CAROUSEL ====================

  Widget _buildManualCarousel() {
    return Column(
      children: [
        // Title
        const Padding(
          padding: EdgeInsets.only(top: 24, bottom: 16),
          child: Text(
            'Manual Carousel',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Carousel
        SizedBox(
          height: 250,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemCount: items.length,
            itemBuilder: (context, index) {
              return _buildCarouselCard(items[index]);
            },
          ),
        ),

        // Indicators
        const SizedBox(height: 16),
        _buildCarouselIndicators(),

        // Navigation Buttons
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  if (_currentIndex > 0) {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Previous'),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () {
                  if (_currentIndex < items.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Next'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==================== AUTO-PLAY CAROUSEL ====================

  Widget _buildAutoPlayCarousel() {
    return Column(
      children: [
        // Title
        const Padding(
          padding: EdgeInsets.only(top: 24, bottom: 16),
          child: Text(
            'Auto-Play Carousel',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        // Carousel with simple scroll
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 280,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: _buildSimpleCarouselCard(items[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ==================== BUILD CAROUSEL CARD ====================

  Widget _buildCarouselCard(CarouselItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: item.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: item.color.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Large emoji
          Text(
            item.image,
            style: const TextStyle(fontSize: 80),
          ),
          const SizedBox(height: 16),

          // Title
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // Subtitle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              item.subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleCarouselCard(CarouselItem item) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: item.color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item.image,
              style: const TextStyle(fontSize: 50),
            ),
            const SizedBox(height: 12),
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ==================== CAROUSEL INDICATORS ====================

  Widget _buildCarouselIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        items.length,
            (index) => GestureDetector(
          onTap: () {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          },
          child: AnimatedContainer(
            width: _currentIndex == index ? 32 : 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: _currentIndex == index
                  ? Colors.blueAccent
                  : Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
            duration: const Duration(milliseconds: 300),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carousel Slider Demo'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Manual Carousel
            _buildManualCarousel(),

            // Divider
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Divider(thickness: 2),
            ),

            // Auto-Play Carousel
            _buildAutoPlayCarousel(),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
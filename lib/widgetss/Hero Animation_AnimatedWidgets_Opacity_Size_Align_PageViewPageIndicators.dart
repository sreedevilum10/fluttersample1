import 'package:flutter/material.dart';

void main() {
  runApp(const AnimationDemoApp());
}

class AnimationDemoApp extends StatelessWidget {
  const AnimationDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const AnimationHomeScreen(),
    );
  }
}

// ==================== HOME SCREEN WITH PAGEVIEW ====================

class AnimationHomeScreen extends StatefulWidget {
  const AnimationHomeScreen({Key? key}) : super(key: key);

  @override
  State<AnimationHomeScreen> createState() => _AnimationHomeScreenState();
}

class _AnimationHomeScreenState extends State<AnimationHomeScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Demo'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          // ==================== PAGEVIEW ====================
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                // Page 1: Hero Animation
                _buildHeroAnimationPage(),

                // Page 2: Animated Opacity
                _buildAnimatedOpacityPage(),

                // Page 3: Animated Size
                _buildAnimatedSizePage(),

                // Page 4: Animated Align
                _buildAnimatedAlignPage(),

                // Page 5: PageView Demo
                _buildPageViewDemoPage(),
              ],
            ),
          ),

          // ==================== PAGE INDICATORS ====================
          _buildPageIndicators(),

          // Navigation Info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Swipe to see more animations →',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== PAGE 1: HERO ANIMATION ====================

  Widget _buildHeroAnimationPage() {
    return Container(
      color: Colors.blue[50],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hero Animation',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const HeroDetailScreen(
                      heroTag: 'avatar',
                      title: 'Hero Animation',
                      description:
                      'Tap the avatar to see hero animation in action!',
                    ),
                  ),
                );
              },
              child: Hero(
                tag: 'avatar',
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueAccent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.4),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      '👤',
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Tap the avatar to see animation',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== PAGE 2: ANIMATED OPACITY ====================

  Widget _buildAnimatedOpacityPage() {
    return AnimatedOpacityDemo();
  }

  // ==================== PAGE 3: ANIMATED SIZE ====================

  Widget _buildAnimatedSizePage() {
    return AnimatedSizeDemo();
  }

  // ==================== PAGE 4: ANIMATED ALIGN ====================

  Widget _buildAnimatedAlignPage() {
    return AnimatedAlignDemo();
  }

  // ==================== PAGE 5: PAGEVIEW DEMO ====================

  Widget _buildPageViewDemoPage() {
    return Container(
      color: Colors.orange[50],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'PageView Demo',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: PageView(
              children: List.generate(
                4,
                    (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: [
                      Colors.orange,
                      Colors.purple,
                      Colors.green,
                      Colors.red,
                    ][index],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ['🎨', '🎭', '🎪', '🎯'][index],
                        style: const TextStyle(fontSize: 80),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Page ${index + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Swipe to see different pages',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ==================== PAGE INDICATORS ====================

  Widget _buildPageIndicators() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          5,
              (index) => GestureDetector(
            onTap: () {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: Container(
              width: _currentPage == index ? 32 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? Colors.blueAccent
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==================== HERO DETAIL SCREEN ====================

class HeroDetailScreen extends StatelessWidget {
  final String heroTag;
  final String title;
  final String description;

  const HeroDetailScreen({
    Key? key,
    required this.heroTag,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Animation'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hero Widget
            Hero(
              tag: heroTag,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueAccent,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.4),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    '👤',
                    style: TextStyle(fontSize: 80),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Back Button
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== ANIMATED OPACITY DEMO ====================

class AnimatedOpacityDemo extends StatefulWidget {
  const AnimatedOpacityDemo({Key? key}) : super(key: key);

  @override
  State<AnimatedOpacityDemo> createState() => _AnimatedOpacityDemoState();
}

class _AnimatedOpacityDemoState extends State<AnimatedOpacityDemo> {
  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[50],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Animated Opacity',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),

            // Animated Opacity Widget
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    '✨',
                    style: TextStyle(fontSize: 60),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Control Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() => _opacity = 0.3);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Fade Out'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() => _opacity = 1.0);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Fade In'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              'Opacity: ${(_opacity * 100).toStringAsFixed(0)}%',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== ANIMATED SIZE DEMO ====================

class AnimatedSizeDemo extends StatefulWidget {
  const AnimatedSizeDemo({Key? key}) : super(key: key);

  @override
  State<AnimatedSizeDemo> createState() => _AnimatedSizeDemoState();
}

class _AnimatedSizeDemoState extends State<AnimatedSizeDemo> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple[50],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Animated Size',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),

            // Animated Size Widget
            AnimatedSize(
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
              child: Container(
                width: _isExpanded ? 200 : 120,
                height: _isExpanded ? 200 : 120,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(
                    _isExpanded ? 20 : 16,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    '📦',
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Toggle Button
            ElevatedButton(
              onPressed: () {
                setState(() => _isExpanded = !_isExpanded);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
              ),
              child: Text(
                _isExpanded ? 'Shrink' : 'Expand',
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Size: ${_isExpanded ? "200x200" : "120x120"}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== ANIMATED ALIGN DEMO ====================

class AnimatedAlignDemo extends StatefulWidget {
  const AnimatedAlignDemo({Key? key}) : super(key: key);

  @override
  State<AnimatedAlignDemo> createState() => _AnimatedAlignDemoState();
}

class _AnimatedAlignDemoState extends State<AnimatedAlignDemo> {
  Alignment _alignment = Alignment.center;

  void _moveToPosition(Alignment newAlignment) {
    setState(() {
      _alignment = newAlignment;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange[50],
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 32),
            child: Text(
              'Animated Align',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Animated Align Widget
          Expanded(
            child: AnimatedAlign(
              alignment: _alignment,
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    '🎯',
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              ),
            ),
          ),

          // Direction Buttons
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Top Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      child: ElevatedButton(
                        onPressed: () =>
                            _moveToPosition(Alignment.topCenter),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Icon(Icons.arrow_upward),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Middle Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      child: ElevatedButton(
                        onPressed: () =>
                            _moveToPosition(Alignment.centerLeft),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 50,
                      child: ElevatedButton(
                        onPressed: () =>
                            _moveToPosition(Alignment.center),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Icon(Icons.public),
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 50,
                      child: ElevatedButton(
                        onPressed: () =>
                            _moveToPosition(Alignment.centerRight),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Bottom Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      child: ElevatedButton(
                        onPressed: () =>
                            _moveToPosition(Alignment.bottomCenter),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Icon(Icons.arrow_downward),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
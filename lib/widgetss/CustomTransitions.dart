import 'package:flutter/material.dart';

void main() {
  runApp(const CustomTransitionsApp());
}

class CustomTransitionsApp extends StatelessWidget {
  const CustomTransitionsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Transitions Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const CustomTransitionsScreen(),
    );
  }
}

// ==================== CUSTOM TRANSITIONS SCREEN ====================

class CustomTransitionsScreen extends StatelessWidget {
  const CustomTransitionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Transitions'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Slide Transition
              _buildTransitionButton(
                context,
                title: 'Slide Transition',
                description: 'Slide in from right',
                icon: Icons.arrow_forward,
                color: Colors.blue,
                transition: SlidePageRoute(
                  page: const DetailScreen(title: 'Slide Transition'),
                ),
              ),
              const SizedBox(height: 16),

              // Fade Transition
              _buildTransitionButton(
                context,
                title: 'Fade Transition',
                description: 'Fade in/out effect',
                icon: Icons.opacity,
                color: Colors.orange,
                transition: FadePageRoute(
                  page: const DetailScreen(title: 'Fade Transition'),
                ),
              ),
              const SizedBox(height: 16),

              // Scale Transition
              _buildTransitionButton(
                context,
                title: 'Scale Transition',
                description: 'Grow from center',
                icon: Icons.zoom_in,
                color: Colors.green,
                transition: ScalePageRoute(
                  page: const DetailScreen(title: 'Scale Transition'),
                ),
              ),
              const SizedBox(height: 16),

              // Rotation Transition
              _buildTransitionButton(
                context,
                title: 'Rotation Transition',
                description: 'Rotate while entering',
                icon: Icons.rotate_right,
                color: Colors.purple,
                transition: RotationPageRoute(
                  page: const DetailScreen(title: 'Rotation Transition'),
                ),
              ),
              const SizedBox(height: 16),

              // Blur Transition
              _buildTransitionButton(
                context,
                title: 'Blur Transition',
                description: 'Blur effect while entering',
                icon: Icons.blur_on,
                color: Colors.red,
                transition: BlurPageRoute(
                  page: const DetailScreen(title: 'Blur Transition'),
                ),
              ),
              const SizedBox(height: 16),

              // Combined Transition
              _buildTransitionButton(
                context,
                title: 'Combined Transition',
                description: 'Slide + Scale + Fade',
                icon: Icons.auto_awesome,
                color: Colors.teal,
                transition: CombinedPageRoute(
                  page: const DetailScreen(title: 'Combined Transition'),
                ),
              ),
              const SizedBox(height: 16),

              // Bounce Transition
              _buildTransitionButton(
                context,
                title: 'Bounce Transition',
                description: 'Bouncy entrance effect',
                icon: Icons.sports_basketball,
                color: Colors.indigo,
                transition: BouncePageRoute(
                  page: const DetailScreen(title: 'Bounce Transition'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransitionButton(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required PageRoute transition,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => Navigator.push(context, transition),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color, color.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 32),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== DETAIL SCREEN ====================

class DetailScreen extends StatelessWidget {
  final String title;

  const DetailScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Large emoji
            const Text('✨', style: TextStyle(fontSize: 100)),
            const SizedBox(height: 32),

            // Title
            Text(
              title,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'This page was opened with a custom $title!',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 48),

            // Back Button
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Go Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== CUSTOM PAGE ROUTES ====================

// 1. Slide Transition
class SlidePageRoute extends PageRouteBuilder {
  final Widget page;

  SlidePageRoute({required this.page}) : super(
        pageBuilder:
            (context, animation, secondaryAnimation) =>page,
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      );
}

// 2. Fade Transition
class FadePageRoute extends PageRouteBuilder {
  final Widget page;

  FadePageRoute({required this.page})
    : super(
        pageBuilder:
            (context, animation, secondaryAnimation) => page,
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
          return FadeTransition(
              opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 600),
      );
}

// 3. Scale Transition
class ScalePageRoute extends PageRouteBuilder {
  final Widget page;

  ScalePageRoute({required this.page})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.elasticOut),
            ),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 700),
      );
}

// 4. Rotation Transition
class RotationPageRoute extends PageRouteBuilder {
  final Widget page;

  RotationPageRoute({required this.page})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return RotationTransition(
            turns: Tween<double>(begin: 0.0, end: 1.0).animate(animation),
            child: ScaleTransition(scale: animation, child: child),
          );
        },
        transitionDuration: const Duration(milliseconds: 600),
      );
}

// 5. Blur Transition
class BlurPageRoute extends PageRouteBuilder {
  final Widget page;

  BlurPageRoute({required this.page})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      );
}

// 6. Combined Transition (Slide + Scale + Fade)
class CombinedPageRoute extends PageRouteBuilder {
  final Widget page;

  CombinedPageRoute({required this.page})
    : super(
        pageBuilder:
            (context, animation, secondaryAnimation) => page,
        transitionsBuilder:
            (context, animation,secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          var scaleTween = Tween<double>(
            begin: 0.8,
            end: 1.0,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: ScaleTransition(
              scale: animation.drive(scaleTween),
              child: FadeTransition(opacity: animation,
                  child: child),
            ),
          );
        },
        transitionDuration:
        const Duration(milliseconds: 700),
      );
}

// 7. Bounce Transition
class BouncePageRoute extends PageRouteBuilder {
  final Widget page;

  BouncePageRoute({required this.page})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var tween = Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).chain(CurveTween(curve: Curves.bounceOut));

          return ScaleTransition(
            scale: animation.drive(tween),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        transitionDuration: const Duration(milliseconds: 800),
      );
}

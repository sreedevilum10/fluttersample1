import 'package:flutter/material.dart';

void main() {
  runApp(const RefreshIndicatorApp());
}

class RefreshIndicatorApp extends StatelessWidget {
  const RefreshIndicatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RefreshIndicator Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const RefreshIndicatorScreen(),
    );
  }
}

// ==================== DATA MODEL ====================

class Post {
  final int id;
  final String title;
  final String author;
  final String content;
  final String timestamp;
  final int likes;

  Post({
    required this.id,
    required this.title,
    required this.author,
    required this.content,
    required this.timestamp,
    required this.likes,
  });
}

// ==================== MAIN SCREEN ====================

class RefreshIndicatorScreen extends StatefulWidget {
  const RefreshIndicatorScreen({Key? key}) : super(key: key);

  @override
  State<RefreshIndicatorScreen> createState() => _RefreshIndicatorScreenState();
}

class _RefreshIndicatorScreenState extends State<RefreshIndicatorScreen> {
  // Sample posts list
  List<Post> posts = [];

  // Loading and error states
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    // Load initial data
    _loadPosts();
  }

  // ==================== LOAD POSTS FUNCTION ====================
  Future<void> _loadPosts() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Create sample posts
      posts = [
        Post(
          id: 1,
          title: 'Flutter RefreshIndicator Guide',
          author: 'John Doe',
          content:
              'Learn how to implement pull-to-refresh in Flutter applications.',
          timestamp: '2 hours ago',
          likes: 234,
        ),
        Post(
          id: 2,
          title: 'State Management Best Practices',
          author: 'Jane Smith',
          content:
              'Explore different state management solutions in Flutter ecosystem.',
          timestamp: '4 hours ago',
          likes: 189,
        ),
        Post(
          id: 3,
          title: 'Custom Widgets in Flutter',
          author: 'Mike Johnson',
          content:
              'Create beautiful and reusable custom widgets for your apps.',
          timestamp: '6 hours ago',
          likes: 342,
        ),
        Post(
          id: 4,
          title: 'API Integration Tutorial',
          author: 'Sarah Williams',
          content: 'Complete guide to integrating REST APIs in Flutter.',
          timestamp: '8 hours ago',
          likes: 267,
        ),
        Post(
          id: 5,
          title: 'Animation Fundamentals',
          author: 'Tom Brown',
          content: 'Master implicit and explicit animations in Flutter.',
          timestamp: '10 hours ago',
          likes: 198,
        ),
      ];

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Error: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  // ==================== REFRESH FUNCTION ====================
  // This is the key function called when user pulls to refresh

  Future<void> _refreshPosts() async {
    try {
      // Simulate network request
      await Future.delayed(const Duration(seconds: 2));

      // In real app, fetch new data from API
      // For demo, we'll add new posts at the beginning
      List<Post> newPosts = [
        Post(
          id: DateTime.now().millisecondsSinceEpoch,
          title: 'Newly Fetched Post',
          author: 'New Author',
          content: 'This post was added by refresh action at ${DateTime.now()}',
          timestamp: 'just now',
          likes: 0,
        ),
      ];

      setState(() {
        // Add new posts to the beginning of list
        posts = [...newPosts, ...posts];
      });

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Posts refreshed successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Handle error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error refreshing posts: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RefreshIndicator Demo'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: isLoading && posts.isEmpty
          ? _buildLoadingState()
          : errorMessage != null
          ? _buildErrorState()
          : _buildRefreshIndicatorWidget(),
    );
  }

  // ==================== BUILD REFRESHINDICATOR WIDGET ====================

  Widget _buildRefreshIndicatorWidget() {
    return RefreshIndicator(
      // Key properties:
      onRefresh: _refreshPosts,
      // Called when user pulls down
      color: Colors.blueAccent,
      // Color of the refresh spinner
      backgroundColor: Colors.white,
      // Background of spinner
      strokeWidth: 3,
      // Width of spinner stroke
      displacement: 40,
      // Distance to trigger refresh (default 40)

      // Advanced properties:
      notificationPredicate: (notification) {
        // Determine which scrolls trigger refresh
        return notification.depth == 0;
      },

      // Build the refreshing content
      child: posts.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PostCard(post: posts[index]);
              },
            ),
    );
  }

  // ==================== LOADING STATE ====================

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
          ),
          const SizedBox(height: 16),
          const Text(
            'Loading posts...',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // ==================== ERROR STATE ====================

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red.withValues()),
          const SizedBox(height: 16),
          Text(
            errorMessage ?? 'An error occurred',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.red),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _loadPosts,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  // ==================== EMPTY STATE ====================

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: Colors.grey.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'No posts available',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          const Text(
            'Pull down to refresh',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

// ==================== POST CARD WIDGET ====================

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post Title
            Text(
              post.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            // Author & Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        post.author[0],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.author,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          post.timestamp,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Post Content
            Text(
              post.content,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.5,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),

            // Like Button
            Row(
              children: [
                Icon(Icons.favorite_border, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  '${post.likes} likes',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('You liked "${post.title}"'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: const Text('Like'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== ADVANCED EXAMPLE SCREEN ====================

class AdvancedRefreshIndicatorScreen extends StatefulWidget {
  const AdvancedRefreshIndicatorScreen({Key? key}) : super(key: key);

  @override
  State<AdvancedRefreshIndicatorScreen> createState() =>
      _AdvancedRefreshIndicatorScreenState();
}

class _AdvancedRefreshIndicatorScreenState
    extends State<AdvancedRefreshIndicatorScreen> {
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      items = List.generate(10, (index) => 'Item ${index + 1}');
    });
  }

  Future<void> _refreshItems() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      // Add refreshed items
      items = ['Refreshed Item ${DateTime.now().millisecond}', ...items];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced RefreshIndicator'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshItems,
        color: Colors.blueAccent,
        backgroundColor: Colors.white,

        // Custom refresh trigger condition
        notificationPredicate: (notification) {
          // Only allow refresh on outer scroll
          return notification.depth == 0;
        },

        child: items.isEmpty
            ? const Center(child: Text('No items'))
            : ListView.separated(
                itemCount: items.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text('${index + 1}'),
                    ),
                    title: Text(items[index]),
                    subtitle: const Text('Tap to view details'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Tapped ${items[index]}'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}

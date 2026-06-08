import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttersample1/StateManagement/ProviderDemos/Provider_Five/providers/posts_provider.dart';
import '../widgets/error_view.dart';
import '../widgets/post_card.dart';

class PostScreen extends StatelessWidget {
  Future<void> _refreshPosts(BuildContext context) async {
    await context.read<PostsProvider>().fetchPost();
  }

  @override
  Widget build(BuildContext context) {

    // Fetch API when view loads
    Future.microtask(() {
      context.read<PostsProvider>().fetchPost();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        centerTitle: true,
      ),

      body: Consumer<PostsProvider>(
        builder: (context, provider, child) {

          // Loading
          if (provider.isLoading && provider.posts.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Error
          if (provider.errorMessage.isNotEmpty &&
              provider.posts.isEmpty) {
            return ErrorView(
              message: provider.errorMessage,
              onRetry: provider.fetchPost,
            );
          }

          // Empty State
          if (provider.posts.isEmpty) {
            return const Center(
              child: Text('No Posts Found'),
            );
          }

          // Success State
          return RefreshIndicator(
            onRefresh: () => _refreshPosts(context),

            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: provider.posts.length,
              itemBuilder: (context, index) {
                final post = provider.posts[index];
                return PostCard(
                  post: post,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      showDragHandle: true,
                      builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 16),

                                Text(
                                  post.body,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
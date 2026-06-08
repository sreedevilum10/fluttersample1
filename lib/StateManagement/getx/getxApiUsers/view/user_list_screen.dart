
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../viewmodel/user_controller.dart';
import 'user_detail_screen.dart';

class UserListScreen extends StatelessWidget {
  // Register the controller once here
  final ctrl = Get.put(UserController());

  UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: ctrl.fetchUsers,
          ),
        ],
      ),

      // Obx rebuilds this widget whenever isLoading, errorMsg, or users changes
      body: Obx(() {
        // ── Loading spinner ──
        if (ctrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        // ── Error message ──
        if (ctrl.errorMsg.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 12),
                Text(ctrl.errorMsg.value, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: ctrl.fetchUsers,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        // ── User list ──
        return RefreshIndicator(
          onRefresh: ctrl.fetchUsers,
          child: ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: ctrl.users.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (_, index) {
              final user = ctrl.users[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    child: Text(
                      user.name[0],
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(
                    user.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(user.email),
                  trailing: const Icon(Icons.chevron_right, color: Colors.deepPurple),
                  onTap: () => Get.to(() => UserDetailScreen(user: user)),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

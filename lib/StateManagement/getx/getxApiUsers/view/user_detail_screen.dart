import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/user_model.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ── Avatar ──────────────────────────────────────────────────────
            CircleAvatar(
              radius: 48,
              backgroundColor: Colors.deepPurple,
              child: Text(
                user.name[0],
                style: const TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Text(user.name,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text('ID: #${user.id}',
                style: const TextStyle(color: Colors.grey)),

            const SizedBox(height: 24),

            // ── Info cards ───────────────────────────────────────────────────
            _infoCard(Icons.email,    'Email',   user.email),
            _infoCard(Icons.phone,    'Phone',   user.phone),
            _infoCard(Icons.language, 'Website', user.website),
            _infoCard(Icons.location_city, 'City', user.city),
            _infoCard(Icons.business, 'Company', user.companyName),

            const SizedBox(height: 24),

            // ── Back button ──────────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: Get.back,
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back to Users'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.deepPurple),
        title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        subtitle: Text(value, style: const TextStyle(fontSize: 15, color: Colors.black87)),
      ),
    );
  }
}

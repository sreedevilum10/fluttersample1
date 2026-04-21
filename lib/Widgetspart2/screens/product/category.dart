
// ================= CATEGORY =================
import 'package:flutter/material.dart';

class ProductCategoryPage extends StatelessWidget {
  final categories = ["Electronics", "Fashion", "Home", "Toys"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories")),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.category),
            title: Text(categories[index]),
          );
        },
      ),
    );
  }
}

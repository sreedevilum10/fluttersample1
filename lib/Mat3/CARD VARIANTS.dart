// ==========================
// CARD VARIANTS DEMO
// ==========================

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: CardVariantsDemo()));
}

class CardVariantsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Card Variants")),
      body: Column(
        children: [
          // Elevated Card
          Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('Elevated Card'),
            ),
          ),

          // Filled Card
          Card(
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('Filled Card'),
            ),
          ),

          // Outlined Card
          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('Outlined Card'),
            ),
          ),
        ],
      ),
    );
  }
}
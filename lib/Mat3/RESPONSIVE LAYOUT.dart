// ==========================
// RESPONSIVE LAYOUT DEMO
// ==========================

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: ResponsiveDemo()));
}

class ResponsiveDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Responsive Layout")),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return Center(child: Text("Mobile View"));
          } else if (constraints.maxWidth < 1200) {
            return Center(child: Text("Tablet View"));
          } else {
            return Center(child: Text("Desktop View"));
          }
        },
      ),
    );
  }
}
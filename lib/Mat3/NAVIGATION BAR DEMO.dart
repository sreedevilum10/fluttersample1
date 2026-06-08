// ==========================
// NAVIGATION BAR DEMO
// ==========================

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: NavigationBarDemo()));
}

class NavigationBarDemo extends StatefulWidget {
  @override
  State<NavigationBarDemo> createState() => _NavigationBarDemoState();
}

class _NavigationBarDemoState extends State<NavigationBarDemo> {
  int _index = 0;

  final pages = [
    Center(child: Text("Explore")),
    Center(child: Text("Commute")),
    Center(child: Text("Saved")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("NavigationBar")),
      body: pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) {
          setState(() => _index = i);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.explore), label: "Explore"),
          NavigationDestination(icon: Icon(Icons.commute), label: "Commute"),
          NavigationDestination(icon: Icon(Icons.bookmark), label: "Saved"),
        ],
      ),
    );
  }
}
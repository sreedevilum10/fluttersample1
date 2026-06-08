// ==========================
// SCROLLABLE APPBAR + PINNED SEARCH BAR
// ==========================

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ScrollWithSearchScreen(),
  ));
}

class ScrollWithSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ==========================
          // SCROLLABLE APP BAR
          // ==========================
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("My App"),
              background: Image.network(
                "https://images.unsplash.com/photo-1649293951243-fa1d11aaac83?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ==========================
          // PINNED SEARCH BAR
          // ==========================
          SliverPersistentHeader(
            pinned: false,
            delegate: SearchBarDelegate(),
          ),

          // ==========================
          // LIST CONTENT
          // ==========================
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text("Item $index"),
                );
              },
              childCount: 30,
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================
// SEARCH BAR DELEGATE
// ==========================
class SearchBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 70;

  @override
  double get maxExtent => 70;

  @override
  Widget build(BuildContext context,
      double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search...",
          prefixIcon: Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding: EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SearchBarDelegate oldDelegate) {
    return false;
  }
}
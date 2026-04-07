import 'package:flutter/material.dart';

class ListViewTwo extends StatelessWidget {
  const ListViewTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 8,
          itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.network(
                "https://plus.unsplash.com/premium_photo-1668068619895-040c047c4111?q=80&w=1142&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              ),
        );
      }),
    );
  }
}

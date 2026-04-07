import 'package:flutter/material.dart';

class ListViewOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ListView - 1")),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: List.generate(
          10,
          (index) => Padding(
            padding: const EdgeInsets.only(bottom :50.0),
            child: Image.network(
              "https://plus.unsplash.com/premium_photo-1668068619895-040c047c4111?q=80&w=1142&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            ),
          ),
        ),



        // children: [
        //   Image.network(
        //     "https://plus.unsplash.com/premium_photo-1668068619895-040c047c4111?q=80&w=1142&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        //   ),
        //   Image.network(
        //     "https://plus.unsplash.com/premium_photo-1668068619895-040c047c4111?q=80&w=1142&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        //   ),
        //   Image.network(
        //     "https://plus.unsplash.com/premium_photo-1668068619895-040c047c4111?q=80&w=1142&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        //   ),
        //   Image.network(
        //     "https://plus.unsplash.com/premium_photo-1668068619895-040c047c4111?q=80&w=1142&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        //   ),
        //   Image.network(
        //     "https://plus.unsplash.com/premium_photo-1668068619895-040c047c4111?q=80&w=1142&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        //   ),
        //   Image.network(
        //     "https://plus.unsplash.com/premium_photo-1668068619895-040c047c4111?q=80&w=1142&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        //   ),
        //   Image.network(
        //     "https://plus.unsplash.com/premium_photo-1668068619895-040c047c4111?q=80&w=1142&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        //   ),
        //   Image.network(
        //     "https://plus.unsplash.com/premium_photo-1668068619895-040c047c4111?q=80&w=1142&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        //   ),
        //   Image.network(
        //     "https://plus.unsplash.com/premium_photo-1668068619895-040c047c4111?q=80&w=1142&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        //   ),
        // ],
      ),
    );
  }
}

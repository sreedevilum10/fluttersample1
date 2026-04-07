import 'package:flutter/material.dart';

class RowExp extends StatelessWidget {
  const RowExp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Header'),
          Row(
            children: [
              Container(width: 50, height: 50, color: Colors.red),
              SizedBox(width: 10),
              Container(width: 50, height: 50, color: Colors.blue),
            ],
          ),
          Text('Footer'),
        ],
      )
    );
      //Center(
    //   child: Row(
    //     //mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     //crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Expanded(
    //         child: Image.network(
    //           height: 160,
    //           //width: 500,
    //           "https://plus.unsplash.com/premium_photo-1668068619895-040c047c4111?q=80&w=1142&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    //         ),
    //       ),
    //       SizedBox(width: 10),
    //       Image.network(
    //         height: 160,
    //         //width: 500,
    //         "https://plus.unsplash.com/premium_photo-1668068619895-040c047c4111?q=80&w=1142&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    //       ),
    //       SizedBox(width: 10),
    //       Expanded(
    //         child: Image.network(
    //           height: 160,
    //           //width: 500,
    //           "https://plus.unsplash.com/premium_photo-1668068619895-040c047c4111?q=80&w=1142&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    //         ),
    //       ),
    //
    //     ],
    //   ),
    // );
  }
}

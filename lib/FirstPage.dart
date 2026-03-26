import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          ///for setting background image
          // image: DecorationImage(
          //   fit: BoxFit.cover,
          //   image: NetworkImage(
          //     "https://images.unsplash.com/photo-1528459801416-a9e53bbf4e17?q=80&w=712&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          //   ),
          // ),
          gradient: LinearGradient(
            end: Alignment.bottomRight,
            begin: Alignment.topLeft,
            colors: [Colors.blueAccent, Colors.white,Colors.blue, Colors.yellow,
              Colors.orange, Colors.white,Colors.brown]
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/butterfly.png"),
                height: 200,
                width: 200,
              ),
              Text(
                "Hello",
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

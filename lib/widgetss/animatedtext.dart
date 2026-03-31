import 'package:flutter/material.dart';

class AnimatedTextWidget extends StatefulWidget {
  @override
  State<AnimatedTextWidget> createState() => _AnimatedTextWidgetState();
}

class _AnimatedTextWidgetState extends State<AnimatedTextWidget> {
  String displayText = 'Hello';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 400,
        width: 300,
        //color: Colors.green,
        padding: EdgeInsets.only(left: 20,bottom: 90),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.white, Colors.orange, Colors.red],
            stops: [0.3, 0.7, 1.0],
          ),
          //shape: BoxShape.circle,
          borderRadius: BorderRadius.only(
            // topLeft: Radius.circular(60),
             topRight: Radius.circular(90),
            bottomLeft: Radius.circular(80),
            //bottomRight: Radius.circular(50),
          ),
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(displayText, style: TextStyle(fontSize: 24)),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  displayText = "New Text";
                });
              },
              child: Text("Update Text"),
            ),
          ],
        ),
      ),
    );
  }
}

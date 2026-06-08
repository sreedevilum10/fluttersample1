// ==========================
// ADAPTIVE BUTTON DEMO
// ==========================
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MaterialApp(home: AdaptiveButtonDemo()));
}

class AdaptiveButtonDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Adaptive Button")),
      body: Center(
        child: Platform.isIOS
            ? CupertinoButton(
          child: Text("iOS Button"),
          onPressed: () {},
        )
            : ElevatedButton(
          child: Text("Android Button"),
          onPressed: () {},
        ),
      ),
    );
  }
}
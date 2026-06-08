// ==========================
// BUTTON TYPES DEMO
// ==========================

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: ButtonTypesDemo()));
}

class ButtonTypesDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buttons")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton(onPressed: () {}, child: Text('Filled')),
          FilledButton.tonal(onPressed: () {}, child: Text('Tonal')),
          ElevatedButton(onPressed: () {}, child: Text('Elevated')),
          OutlinedButton(onPressed: () {}, child: Text('Outlined')),
          TextButton(onPressed: () {}, child: Text('Text')),
        ],
      ),
    );
  }
}
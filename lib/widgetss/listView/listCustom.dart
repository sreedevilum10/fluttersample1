import 'package:flutter/material.dart';

class ListViewFour extends StatelessWidget {

  var names = ["Anu","Bindu","Ciya","Dennis"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.custom(
        childrenDelegate: SliverChildBuilderDelegate((context, index) {
          return Card(
            color: Colors.green,
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text(names[index]),
              subtitle: Text("876543232456"),
              trailing: Icon(Icons.phone),
            ),
          );
        }, childCount: 4),

        // childrenDelegate: SliverChildListDelegate(
        //   List.generate(
        //     20,
        //     (index) =>
        //     Card(
        //       child: ListTile(
        //         leading: Icon(Icons.person),
        //         title: Text("Name $index"),
        //         subtitle: Text("876543232456"),
        //         trailing: Icon(Icons.phone),
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ListViewThree extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
          itemBuilder: (con,i){
            return Card(
              child:  Center(child: Text("$i")),
            );
          },
          separatorBuilder: (context, index){
            return Divider(thickness: 4,color: Colors.blue ,);
          },
          itemCount: 10),
    );
  }
}

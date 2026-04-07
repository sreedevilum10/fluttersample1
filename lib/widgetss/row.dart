import 'package:flutter/material.dart';

class RowEx extends StatelessWidget {
  const RowEx({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
              flex: 2,
              child: Image.network(
                height: 160,
                //width: 500,
                "https://plus.unsplash.com/premium_photo-1668068619895-040c047c4111?q=80&w=1142&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              ),),
          SizedBox(width: 10,),
          Flexible(
              flex:1,
              child: Image.network(
                height: 160,
                //width: 500,
                "https://plus.unsplash.com/premium_photo-1668068619895-040c047c4111?q=80&w=1142&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              ),),
          SizedBox(width: 10,),

          Flexible(
            flex: 1,
            child: Image.network(
              height: 160,
              //width: 500,
              "https://plus.unsplash.com/premium_photo-1668068619895-040c047c4111?q=80&w=1142&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            ),
          ),
          Flexible(
            flex:2,
            child: Image.network(
              //width: 500,
              "https://plus.unsplash.com/premium_photo-1668068619895-040c047c4111?q=80&w=1142&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            ),
          ),
        ],
      ),
    );
  }
}

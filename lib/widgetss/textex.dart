import 'package:flutter/material.dart';

class TextEx extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue.shade700,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 10,
                    offset: Offset(2, 2),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 40,
                    offset: Offset(2, 1),
                  ),
                ],
          ),
          child: Text(
            'Text with Background',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )

        // Container(
        //   padding: EdgeInsets.all(16),
        //   decoration: BoxDecoration(
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.yellow,
        //         blurRadius: 10,
        //         offset: Offset(2, 2),
        //       ),
        //       BoxShadow(
        //         color: Colors.red,
        //         blurRadius: 40,
        //         offset: Offset(2, 1),
        //       ),
        //       BoxShadow(
        //         color: Colors.green,
        //         blurRadius: 40,
        //         offset: Offset(2, 2),
        //       ),
        //     ],
        //   ),
        //   child: Text(
        //     'Text with Shadow',
        //     style: TextStyle(
        //       fontSize: 24,
        //       fontWeight: FontWeight.bold,
        //       color: Colors.white,
        //     ),
        //   ),
        // )
        // SelectableText(
        //   'Users can select and copy this text',
        //   style: TextStyle(fontSize: 16),
        //   toolbarOptions: ToolbarOptions(
        //     copy: true,
        //     selectAll: true,
        //   ),
        // )
        // RichText(
        //     text: TextSpan(
        //         text: "Hello",
        //         style: TextStyle(
        //           color: Colors.blue,
        //           fontWeight: FontWeight.bold,
        //           fontSize: 50,
        //         ),
        //     children: [
        //       TextSpan(text: " Welcome",
        //         style: TextStyle(
        //           color: Colors.yellow,
        //           fontStyle: FontStyle.italic,
        //           fontSize: 38,
        //         ),),
        //       TextSpan(text: " to Flutter",
        //         style: TextStyle(
        //           //color: Colors.red,
        //           fontStyle: FontStyle.italic,
        //           fontSize: 20,
        //           decoration: TextDecoration.underline,
        //           decorationColor: Colors.orange,
        //         ),
        //       )
        //     ]),),

        // Text(
        //   'This is a very long text that might overflow on small screens',
        //   maxLines: 2,
        //   overflow: TextOverflow.ellipsis,
        //   style: TextStyle(
        //     fontSize: 50,
        //     fontWeight: FontWeight.bold,
        //     color: Colors.blue,
        //     fontStyle: FontStyle.italic,
        //   ),
        //   textAlign: TextAlign.center,
        // ),
      ),
    );
  }
}

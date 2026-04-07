import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';

class NestedContainers extends StatelessWidget {
  String displayText = 'Hello';

  NestedContainers({super.key});

  @override
  Widget build(BuildContext context) {
    return // Nested containers
      // Transform.rotate(
      //   angle:70,
      //   child:
        Container(
          width: 200,
            height: 300,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                padding: EdgeInsets.all(15),
                  color: Colors.red[300],
                child: ClipPath(
                  clipper:
                  SinCosineWaveClipper(),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.yellow[500],
                    child: Center(
                      child: Text(
                        'Nested',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
       // ),
      );
  }
}

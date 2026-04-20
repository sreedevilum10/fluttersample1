import 'package:flutter/material.dart';

import '../model/fruitsModel.dart';

// ================= DETAILS PAGE =================
class Detailspage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Fruit fruit =
    ModalRoute.of(context)!.settings.arguments as Fruit;

    return Scaffold(
      appBar: AppBar(title: Text("Fruit Details")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // IMAGE
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  fruit.image,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(height: 20),

              Text(
                fruit.name,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 10),

              Text(
                "Color: ${fruit.color}",
                style: TextStyle(fontSize: 20),
              ),

              SizedBox(height: 30),

              ElevatedButton.icon(
                icon: Icon(Icons.arrow_back),
                label: Text("Go Back"),

                onPressed: () {
                  Navigator.pop(
                    context,
                    "You selected ${fruit.name}",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

// ================= MODEL =================
class Fruit {
  final int id;
  final String name;
  final String color;
  final String image;

  Fruit({
    required this.id,
    required this.name,
    required this.color,
    required this.image,
  });
}

// ================= APP =================
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/details': (context) => DetailsPage(),
      },
    );
  }
}

// ================= HOME PAGE =================
class HomePage extends StatelessWidget {
  final List<Fruit> fruits = [
    Fruit(
      id: 1,
      name: "Apple",
      color: "Red",
      image: "assets/butterfly.png",
    ),
    Fruit(
      id: 2,
      name: "Banana",
      color: "Yellow",
      image: "assets/butterfly.png",
    ),
    Fruit(
      id: 3,
      name: "Mango",
      color: "Orange",
      image: "assets/butterfly.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fruits List")),

      body: ListView.builder(
        itemCount: fruits.length,
        itemBuilder: (context, index) {
          final fruit = fruits[index];

          return Card(
            margin: EdgeInsets.all(10),
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(fruit.image),
              ),
              title: Text(fruit.name),
              subtitle: Text("Color: ${fruit.color}"),
              trailing: Icon(Icons.arrow_forward_ios),

              onTap: () async {
                final result = await Navigator.pushNamed(
                  context,
                  '/details',
                  arguments: fruit,
                );

                if (result != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result.toString())),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

// ================= DETAILS PAGE =================
class DetailsPage extends StatelessWidget {
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
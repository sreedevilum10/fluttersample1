import 'package:flutter/material.dart';
import '../../model/fruitmodel/fruitsModel.dart';

class Homepage extends StatelessWidget {

  final List<Fruit> fruits = [
    Fruit(id: 1, name: "Apple", color: "Red", image: "assets/butterfly.png"),
    Fruit(id: 2, name: "Banana", color: "Yellow", image: "assets/butterfly.png"),
    Fruit(id: 3, name: "Mango", color: "Orange", image: "assets/butterfly.png"),
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
                  backgroundImage: AssetImage(fruit.image)
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
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(result.toString())));
                }
              },
            ),
          );
        },
      ),
    );
  }
}

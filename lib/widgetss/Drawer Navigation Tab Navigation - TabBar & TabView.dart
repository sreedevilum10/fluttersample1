import 'package:flutter/material.dart';
import 'package:fluttersample1/widgetss/rowWithExp.dart';

void main() {
  runApp(MyApp());
}

// ================= MODEL =================
class Fruit {
  final String name;
  final String color;
  final String image;

  Fruit({required this.name, required this.color, required this.image});
}

// ================= APP =================
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Advanced UI",
      theme: ThemeData(primarySwatch: Colors.deepPurple, useMaterial3: true),
      routes: {
        '/': (context) => HomePage(),
        '/details': (context) => DetailsPage(),
      },
    );
  }
}

// ================= HOME =================
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedDrawerIndex = 0;

  final List<Fruit> fruits = [
    Fruit(name: "Apple", color: "Red", image: "assets/butterfly.png"),
    Fruit(name: "Banana", color: "Yellow", image: "assets/butterfly.png"),
    Fruit(name: "Mango", color: "Orange", image: "assets/butterfly.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      animationDuration: Duration(milliseconds: 400),
      child: Scaffold(
        appBar: AppBar(
          actions: [Icon(Icons.notification_add) ],
          title: Text("Advanced Drawer + Tabs"),
          // 🔥 ADVANCED TABBAR
          bottom: TabBar(
            //isScrollable: true,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.purpleAccent,
            ),
            indicatorPadding: EdgeInsets.symmetric(vertical: 1, horizontal: .8),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),

            tabs: [
              Tab(icon: Icon(Icons.list), text: "List View"),
              Tab(icon: Icon(Icons.grid_view), text: "Grid View"),
              Tab(icon: Icon(Icons.table_chart), text: "Data Table"),
            ],
          ),
        ),

        // ================= DRAWER =================
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // 🔥 HEADER
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue
                //   image: DecorationImage(
                //     image: AssetImage("assets/butterfly.png"),
                //     fit: BoxFit.cover,
                //   ),
          ),
                accountName: Text(
                  "Sreedevi",
                  style: TextStyle(color: Colors.amberAccent),
                ),
                accountEmail: Text(
                  "user@email.com",
                  style: TextStyle(color: Colors.amberAccent),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 30),
                ),
                otherAccountsPictures: [
                  CircleAvatar(
                    backgroundColor: Colors.purpleAccent,
                    child: Icon(Icons.account_circle,
                        size: 30))
                ],
              ),

              // 🔹 MENU ITEMS
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                selected: selectedDrawerIndex == 0,
                selectedTileColor:
                Colors.deepPurple.shade100,
                onTap: () {
                  setState(() => selectedDrawerIndex = 0);
                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: Icon(Icons.info),
                title: Text("Apple Details"),
                selected: selectedDrawerIndex == 1,
                onTap: () {
                  setState(() => selectedDrawerIndex = 1);
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    '/details',
                    arguments: fruits[0],
                  );
                },
              ),

              ListTile(
                leading: Icon(Icons.info_outline),
                title: Text("Banana Details"),
                selected: selectedDrawerIndex == 2,
                onTap: () {
                  setState(() => selectedDrawerIndex = 2);
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    '/details',
                    arguments: fruits[1],
                  );
                },
              ),

              Divider(),

              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text("Logout"),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Logged out")));
                },
              ),
            ],
          ),
        ),

        // ================= TAB VIEW =================
        body: TabBarView(
          children: [
            //  RowExp(),
            // 🔹 LIST VIEW
            ListView.builder(
              itemCount: fruits.length,
              itemBuilder: (context, index) {
                final fruit = fruits[index];

                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(fruit.image),
                    ),
                    title: Text(fruit.name),
                    subtitle: Text(fruit.color),
                    trailing: Icon(Icons.arrow_forward_ios),

                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/details',
                        arguments: fruit,
                      );
                    },
                  ),
                );
              },
            ),

            // 🔹 GRID VIEW
            GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: fruits.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final fruit = fruits[index];

                return Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    splashColor: Colors.deepPurple.withOpacity(0.3),

                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/details',
                        arguments: fruit,
                      );
                    },

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(fruit.image, height: 80),
                        SizedBox(height: 10),
                        Text(
                          fruit.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            // 🔹 DATA TABLE
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 30,
                headingRowColor: WidgetStateProperty.all(
                  Colors.deepPurple.shade100,
                ),
                border: TableBorder.all(),

                columns: [
                  DataColumn(label: Text("Name")),
                  DataColumn(label: Text("Color")),
                ],

                rows: fruits.map((fruit) {
                  return DataRow(
                    cells: [
                      DataCell(Text(fruit.name)),
                      DataCell(Text(fruit.color)),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= DETAILS =================
class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Fruit fruit = ModalRoute.of(context)!.settings.arguments as Fruit;

    return Scaffold(
      appBar: AppBar(title: Text(fruit.name)),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(tag: fruit.name, child: Image.asset(fruit.image, height: 150)),
            SizedBox(height: 20),
            Text(fruit.name, style: TextStyle(fontSize: 28)),
            Text(fruit.color, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}

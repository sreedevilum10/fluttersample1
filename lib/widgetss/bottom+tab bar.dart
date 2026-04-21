import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// ================= MODEL =================
class Product {
  final String name;
  final double price;
  final String image;

  Product({required this.name, required this.price, required this.image});
}

// ================= APP =================
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Ecommerce UI",
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: MainPage(),
      routes: {'/details': (context) => DetailsPage()},
    );
  }
}

// ================= MAIN PAGE =================
class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final pages = [HomePage(), CategoryPage(), CartPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      // 🧭 Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: false,
        elevation: 10,
        onTap: (index) {
          setState(() => currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile"),
        ],
      ),
    );
  }
}

// ================= HOME (TABS) =================
class HomePage extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: "Shoes",
      price: 999,
      image: "https://images.unsplash.com/photo-1542291026-7eec264c27ff",
    ),
    Product(
      name: "Watch",
      price: 1999,
      image: "https://images.unsplash.com/photo-1511376777868-611b54f68947",
    ),
    Product(
      name: "Bag",
      price: 1499,
      image: "https://images.unsplash.com/photo-1584917865442-de89df76afd3",
    ),
    Product(
      name: "Headset",
      price: 799,
      image: "https://images.unsplash.com/photo-1518449037997-1c2e9e7f8b28",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,

      child: Scaffold(
        appBar: AppBar(
          title: Text("Shop"),

          bottom: TabBar(
            // isScrollable: true,
            indicator: BoxDecoration(color: Colors.deepPurple[100]),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,

            tabs: const [
              Tab(text: "Featured"),
              Tab(text: "Trending"),
              Tab(text: "Offers"),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            buildGrid(context),
            buildGrid(context),
            buildGrid(context),
          ],
        ),
      ),
    );
  }

  //Refactoring widget
  Widget buildGrid(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final product = products[index];

        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.pushNamed(context, '/details', arguments: product);
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 🌐 NETWORK IMAGE
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      product.image,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,

                      // 🔄 loading
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return SizedBox(
                          height: 80,
                          width: 80,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      },

                      // ❌ error
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.broken_image, size: 50);
                      },
                    ),
                  ),

                  SizedBox(height: 10),
                  Text(product.name),
                  Text(
                    "₹${product.price}",
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ================= CATEGORY =================
class CategoryPage extends StatelessWidget {
  final categories = ["Electronics", "Fashion", "Home", "Toys"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categories")),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.category),
            title: Text(categories[index]),
          );
        },
      ),
    );
  }
}

// ================= CART =================
class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: Center(child: Text("Your cart is empty")),
    );
  }
}

// ================= PROFILE =================
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Center(child: Text("User Profile")),
    );
  }
}

// ================= DETAILS =================
class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(product.image, height: 150, fit: BoxFit.cover),

            SizedBox(height: 20),
            Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            Text(
              "₹${product.price}",
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),

            SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart),
              label: Text("Add to Cart"),
            ),
          ],
        ),
      ),
    );
  }
}


// ================= HOME (TABS) =================
import 'package:flutter/material.dart';
import 'package:fluttersample1/Widgetspart2/screens/product/productGrid.dart';
import '../../model/productmodel/product.dart';

class ProductHomePage extends StatelessWidget {
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
            indicator: BoxDecoration(
                color: Colors.deepPurple[100]),
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
            buildGrid(context,products),
            buildGrid(context,products),
            buildGrid(context,products),
          ],
        ),
      ),
    );
  }
}

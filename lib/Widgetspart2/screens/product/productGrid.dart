//Refactoring widget
import 'package:flutter/material.dart';
import 'package:fluttersample1/Widgetspart2/model/productmodel/product.dart';

Widget buildGrid(BuildContext context,List<Product> products) {
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
            Navigator.pushNamed(context, '/details',
                arguments: product);
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 🌐 NETWORK IMAGE
                Flexible(
                  child: ClipRRect(
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
                          child: Center(
                              child: CircularProgressIndicator()),
                        );
                      },

                      // ❌ error
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.broken_image, size: 50);
                      },
                    ),
                  ),
                ),

                SizedBox(height: 10),
                Text(product.name,style: TextStyle(fontSize: 20),),
                Text(
                  "₹${product.price}",
                  style: TextStyle(color: Colors.green,fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
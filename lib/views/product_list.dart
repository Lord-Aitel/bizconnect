import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_detail.dart';

class ProductList extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: "Café de Futrono",
      price: "4500",
      image: "assets/cafe.jpg",
      description: "Café artesanal de Futrono, tostado localmente.",
    ),
    Product(
      name: "Miel de Valdivia",
      price: "6000",
      image: "assets/miel.png",
      description: "Miel pura de la Región de Los Ríos.",
    ),
  ];

  ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Productos")),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            leading: Image.asset(product.image),
            title: Text(product.name),
            subtitle: Text("\$${product.price}"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetail(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../../data/sources/firebase_service.dart';
import '../widgets/product_card.dart';
import 'product_detail.dart';

class ProductList extends StatelessWidget {
  final FirebaseService _firebaseService = FirebaseService();

  ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Productos")),
      body: FutureBuilder<List<Product>>(
        future: _firebaseService.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          final products = snapshot.data ?? [];
          if (products.isEmpty) {
            return const Center(child: Text("No hay productos disponibles"));
          }
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                product: product,
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
          );
        },
      ),
    );
  }
}

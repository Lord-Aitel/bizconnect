import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetail extends StatelessWidget {
  final Product product;
  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(product.image, height: 200),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              "Precio: \$${product.price}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Text(product.description),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Aquí podrías implementar la acción de compra/pedido
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Pedido realizado")),
                );
              },
              child: const Text("Realizar pedido"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';


class ProductDetail extends StatelessWidget {
  final Product product;
  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.nombre)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icono genérico en lugar de imagen
            Container(
              height: 200,
              color: Colors.grey[300],
              child: const Icon(Icons.shopping_bag, size: 80),
            ),
            const SizedBox(height: 16),
            Text(
              product.nombre,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              "Precio: \$${product.precio}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              "Stock disponible: ${product.stock}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
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


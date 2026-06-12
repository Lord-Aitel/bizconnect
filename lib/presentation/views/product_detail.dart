import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetail extends StatelessWidget {
  final Product product;
  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.nombre),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              Share.share(
                'Producto: ${product.nombre}\n'
                'Precio: \$${product.precio.toStringAsFixed(2)}\n'
                'Stock disponible: ${product.stock}\n'
                'Descripción: ${product.descripcion}\n'
                'Valoración: ${product.rating}/5',
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del producto
            product.imagenUrl.isNotEmpty
                ? Image.network(
                    product.imagenUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Icon(Icons.shopping_bag, size: 80),
                  ),
            const SizedBox(height: 16),

            // Nombre
            Text(
              product.nombre,
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            // Precio
            Text(
              "Precio: \$${product.precio.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.titleMedium,
            ),

            // Stock
            Text(
              "Stock disponible: ${product.stock}",
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 16),

            // Descripción
            Text(
              product.descripcion,
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 16),

            // Rating en estrellas
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < product.rating.round()
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.amber,
                );
              }),
            ),

            const SizedBox(height: 24),

            // Botón de acción
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

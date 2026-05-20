import 'package:flutter/material.dart';

class ProductosScreen extends StatelessWidget {
  final String localId;
  final List<Map<String, dynamic>> productos;

  const ProductosScreen({
    super.key,
    required this.localId,
    required this.productos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Productos de $localId")),
      body: ListView.builder(
        itemCount: productos.length,
        itemBuilder: (context, index) {
          final producto = productos[index];
          final nombre = producto['nombre'];
          final precio = producto['precio'];
          final stock = producto['stock'];

          return Card(
            child: ListTile(
              leading: const Icon(Icons.shopping_bag, color: Colors.deepPurple),
              title: Text(nombre),
              subtitle: Text("Precio: \$$precio | Stock: $stock"),
            ),
          );
        },
      ),
    );
  }
}

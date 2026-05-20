import 'package:flutter/material.dart';
import '../../firebase_service.dart';

class CrearProductoScreen extends StatefulWidget {
  const CrearProductoScreen({super.key});

  @override
  State<CrearProductoScreen> createState() => _CrearProductoScreenState();
}

class _CrearProductoScreenState extends State<CrearProductoScreen> {
  final servicio = FirebaseService();
  final _nombreController = TextEditingController();
  final _precioController = TextEditingController();
  final _stockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Crear Producto")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: "Nombre del producto"),
            ),
            TextField(
              controller: _precioController,
              decoration: const InputDecoration(labelText: "Precio"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _stockController,
              decoration: const InputDecoration(labelText: "Stock"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await servicio.agregarProducto(
                  "cafe_futrono", // id del local
                  _nombreController.text,
                  int.parse(_precioController.text),
                  int.parse(_stockController.text),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Producto agregado correctamente")),
                );
              },
              child: const Text("Guardar producto"),
            ),
          ],
        ),
      ),
    );
  }
}

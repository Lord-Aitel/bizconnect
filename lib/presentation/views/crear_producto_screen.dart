import 'package:flutter/material.dart';
import '../../data/sources/firebase_service.dart';

class CrearProductoScreen extends StatefulWidget {
  final String localId; // ahora se pasa dinámicamente
  const CrearProductoScreen({super.key, required this.localId});

  @override
  State<CrearProductoScreen> createState() => _CrearProductoScreenState();
}

class _CrearProductoScreenState extends State<CrearProductoScreen> {
  final servicio = FirebaseService();
  final _nombreController = TextEditingController();
  final _precioController = TextEditingController();
  final _stockController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _precioController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  Future<void> _guardarProducto() async {
    final nombre = _nombreController.text.trim();
    final precio = int.tryParse(_precioController.text.trim());
    final stock = int.tryParse(_stockController.text.trim());

    if (nombre.isEmpty || precio == null || stock == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Completa todos los campos correctamente")),
      );
      return;
    }

    await servicio.agregarProducto(widget.localId, nombre, precio, stock);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Producto agregado correctamente")),
      );
      Navigator.pop(context); // volver a la lista de productos
    }
  }

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
              onPressed: _guardarProducto,
              child: const Text("Guardar producto"),
            ),
          ],
        ),
      ),
    );
  }
}

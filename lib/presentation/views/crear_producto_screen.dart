import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/sources/firebase_service.dart';

class CrearProductoScreen extends StatefulWidget {
  final String localId;
  const CrearProductoScreen({super.key, required this.localId});

  @override
  State<CrearProductoScreen> createState() => _CrearProductoScreenState();
}

class _CrearProductoScreenState extends State<CrearProductoScreen> {
  final servicio = FirebaseService();
  final _nombreController = TextEditingController();
  final _precioController = TextEditingController();
  final _stockController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _ratingController = TextEditingController(); // 🔹 Nuevo campo
  XFile? _imagen;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() => _imagen = picked);
    }
  }

  Future<void> _guardarProducto() async {
    final nombre = _nombreController.text.trim();
    final precio = int.tryParse(_precioController.text.trim()); // 🔹 Precio como int
    final stock = int.tryParse(_stockController.text.trim());
    final descripcion = _descripcionController.text.trim();
    final rating = double.tryParse(_ratingController.text.trim()) ?? 0.0; // 🔹 Rating como double

    if (nombre.isEmpty || precio == null || stock == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Completa todos los campos correctamente")),
      );
      return;
    }

    await servicio.agregarProductoConImagen(
      widget.localId,
      nombre,
      precio.toDouble(), 
      stock,
      descripcion,
      _imagen != null ? File(_imagen!.path) : null,
      rating,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Producto agregado correctamente")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Crear Producto")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _nombreController, decoration: const InputDecoration(labelText: "Nombre")),
            TextField(controller: _precioController, decoration: const InputDecoration(labelText: "Precio"), keyboardType: TextInputType.number),
            TextField(controller: _stockController, decoration: const InputDecoration(labelText: "Stock"), keyboardType: TextInputType.number),
            TextField(controller: _descripcionController, decoration: const InputDecoration(labelText: "Descripción")),
            TextField(controller: _ratingController, decoration: const InputDecoration(labelText: "Valoración (0-5)"), keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            _imagen != null ? Image.file(File(_imagen!.path), height: 150) : const Text("Sin imagen"),
            ElevatedButton(onPressed: _pickImage, child: const Text("Tomar foto")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _guardarProducto, child: const Text("Guardar producto")),
          ],
        ),
      ),
    );
  }
}

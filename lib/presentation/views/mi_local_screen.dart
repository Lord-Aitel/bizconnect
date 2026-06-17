import 'package:flutter/material.dart';
import '../../data/sources/firebase_service.dart';
import 'crear_producto_screen.dart';
import 'product_list.dart';

class MiLocalScreen extends StatefulWidget {
  const MiLocalScreen({super.key});

  @override
  State<MiLocalScreen> createState() => _MiLocalScreenState();
}

class _MiLocalScreenState extends State<MiLocalScreen> {
  final servicio = FirebaseService();
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();

  final String userLocalId = "uid_del_usuario"; 
  // 🔹 Aquí deberías usar el UID real del usuario autenticado

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  Future<void> _crearLocal() async {
    final nombre = _nombreController.text.trim();
    final descripcion = _descripcionController.text.trim();

    if (nombre.isEmpty || descripcion.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Completa todos los campos")),
      );
      return;
    }

    await servicio.crearLocal(userLocalId, nombre, descripcion);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Local creado correctamente")),
      );
      setState(() {}); // refresca la pantalla para mostrar el local
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: servicio.getLocal(userLocalId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData) {
          // 🔹 Formulario para crear el local
          return Scaffold(
            appBar: AppBar(title: const Text("Crear Local")),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    controller: _nombreController,
                    decoration: const InputDecoration(labelText: "Nombre del local"),
                  ),
                  TextField(
                    controller: _descripcionController,
                    decoration: const InputDecoration(labelText: "Descripción"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _crearLocal,
                    child: const Text("Crear mi local"),
                  ),
                ],
              ),
            ),
          );
        }

        final doc = snapshot.data!;
        final data = doc.data() as Map<String, dynamic>;
        final nombreLocal = data['nombre'] ?? 'Mi Local';
        final localId = doc.id;

        return Scaffold(
          appBar: AppBar(title: Text(nombreLocal)),
          body: ProductList(localId: localId),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CrearProductoScreen(localId: userLocalId),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'productos_screen.dart';

class LocalesScreen extends StatelessWidget {
  const LocalesScreen({super.key});

  // 🔹 Datos locales simulados
  final List<Map<String, dynamic>> locales = const [
    {
      "id": "cafe_futrono",
      "nombre": "Café de Futrono",
      "productos": [
        {"nombre": "Café molido", "precio": 4500, "stock": 20},
        {"nombre": "Té verde", "precio": 3000, "stock": 15},
      ]
    },
    {
      "id": "miel_valdivia",
      "nombre": "Miel de Valdivia",
      "productos": [
        {"nombre": "Miel orgánica", "precio": 6000, "stock": 10},
        {"nombre": "Propóleo", "precio": 3500, "stock": 5},
      ]
    },
    {
      "id": "panaderia_valdivia",
      "nombre": "Panadería Valdivia",
      "productos": [
        {"nombre": "Pan integral", "precio": 2000, "stock": 30},
        {"nombre": "Facturas", "precio": 1500, "stock": 25},
      ]
    },
    {
      "id": "tienda_futrono",
      "nombre": "Tienda Futrono",
      "productos": [
        {"nombre": "Arroz 1kg", "precio": 1200, "stock": 50},
        {"nombre": "Aceite 1L", "precio": 2500, "stock": 40},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Locales disponibles")),
      body: ListView.builder(
        itemCount: locales.length,
        itemBuilder: (context, index) {
          final local = locales[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.store, color: Colors.deepPurple),
              title: Text(local['nombre']),
              subtitle: Text("ID: ${local['id']}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductosScreen(
                      localId: local['id'],
                      productos: local['productos'],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

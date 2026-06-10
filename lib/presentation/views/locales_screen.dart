import 'package:flutter/material.dart';
import '../../data/sources/firebase_service.dart';
import '../../domain/entities/local.dart';
import 'product_list.dart';

class LocalesScreen extends StatelessWidget {
  const LocalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseService firebaseService = FirebaseService();

    return Scaffold(
      appBar: AppBar(title: const Text("Locales disponibles")),
      body: FutureBuilder<List<Local>>(
        future: firebaseService.getLocales(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          final locales = snapshot.data ?? [];
          if (locales.isEmpty) {
            return const Center(child: Text("No hay locales disponibles"));
          }
          return ListView.builder(
            itemCount: locales.length,
            itemBuilder: (context, index) {
              final local = locales[index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.store, color: Colors.deepPurple),
                  title: Text(local.nombre),
                  subtitle: Text("ID: ${local.id}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductList(localId: local.id),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

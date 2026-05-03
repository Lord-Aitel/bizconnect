import 'package:flutter/material.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BizConnect")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text("Menú de navegación", style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text("Productos"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Placeholder(), 
                  ),
                );
              },
            ),
            // aqui se puede expandir con más opciones de navegación
          ],
        ),
      ),
      body: const Center(
        child: Text("Selecciona una opción en el menú"),
      ),
    );
  }
}

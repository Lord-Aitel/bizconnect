import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../presentation/views/locales_viewmodel.dart';
import 'product_list.dart';
import 'mi_local_screen.dart';
import 'about_screen.dart';

class LocalesScreen extends StatelessWidget {
  const LocalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocalesViewModel()..listenToLocales(),
      child: Consumer<LocalesViewModel>(
        builder: (context, vm, _) {
          if (vm.loading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (vm.locales.isEmpty) {
            return const Scaffold(
              body: Center(child: Text("No hay locales disponibles")),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text("Locales disponibles"),
              actions: [
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'mi_local') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MiLocalScreen()),
                      );
                    } else if (value == 'about') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AboutScreen()),
                      );
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'mi_local',
                      child: Text("Mi Local"),
                    ),
                    const PopupMenuItem(
                      value: 'about',
                      child: Text("About / Créditos"),
                    ),
                  ],
                ),
              ],
            ),
            body: Column(
              children: [
                // 🔎 Barra de búsqueda
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Buscar local...",
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) => vm.searchLocales(value),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: vm.locales.length,
                    itemBuilder: (context, index) {
                      final local = vm.locales[index];

             
                      if (local.id == vm.userLocalId) {
                        return const SizedBox.shrink();
                      }

                      final isLastVisited = vm.lastLocalId == local.id;

                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.store, color: Colors.deepPurple),
                          title: Text(local.nombre),
                          subtitle: Text("ID: ${local.id}"),
                          trailing: isLastVisited
                              ? const Icon(Icons.check_circle, color: Colors.green)
                              : null,
                          onTap: () {
                            final vmProvider = Provider.of<LocalesViewModel>(
                              context,
                              listen: false,
                            );
                            vmProvider.setLastLocal(local.id);

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
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

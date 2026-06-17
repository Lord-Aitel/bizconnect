import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../presentation/views/locales_viewmodel.dart';
import 'product_list.dart';
import 'mi_local_screen.dart';
import 'about_screen.dart';
import 'feedback_screen.dart'; 

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
                    if (value == 'about') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AboutScreen()),
                      );
                    } else if (value == 'feedback') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const FeedbackScreen()),
                      );
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      enabled: false,
                      child: Text(
                        "Opciones",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'feedback',
                      child: ListTile(
                        leading: Icon(Icons.feedback_outlined),
                        title: Text("Feedback / Encuesta"),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'about',
                      child: ListTile(
                        leading: Icon(Icons.info_outline),
                        title: Text("About / Créditos"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            body: Column(
              children: [
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
                          leading: const Icon(Icons.store, color: Colors.black),
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
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.store),
                  label: const Text("Mi Local"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MiLocalScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

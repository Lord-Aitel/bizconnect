import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../presentation/views/locales_viewmodel.dart';
import 'product_list.dart';

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
            appBar: AppBar(title: const Text("Locales disponibles")),
            body: ListView.builder(
              itemCount: vm.locales.length,
              itemBuilder: (context, index) {
                final local = vm.locales[index];
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
          );
        },
      ),
    );
  }
}

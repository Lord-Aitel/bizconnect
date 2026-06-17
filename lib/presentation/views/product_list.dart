import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../presentation/views/product_viewmodel.dart';
import 'product_detail.dart';

class ProductList extends StatelessWidget {
  final String localId;
  const ProductList({super.key, required this.localId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductViewModel()..listenToProducts(localId),
      child: Consumer<ProductViewModel>(
        builder: (context, vm, _) {
          if (vm.loading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
            appBar: AppBar(title: const Text("Productos")),
            body: Column(
              children: [
                // 🔎 Barra de búsqueda local
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: "Buscar producto en este local...",
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) => vm.searchLocalProducts(value),
                  ),
                ),
                Expanded(
                  child: vm.searchResults.isNotEmpty
                      ? ListView.builder(
                          itemCount: vm.searchResults.length,
                          itemBuilder: (context, index) {
                            final resultado = vm.searchResults[index];
                            final product = resultado["producto"];

                            return Card(
                              child: ListTile(
                                leading: const Icon(Icons.shopping_bag,
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                title: Text(product.nombre),
                                subtitle: Text(
                                    '${product.precio} CLP — Stock: ${product.stock}'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          ProductDetail(product: product),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        )
                      : vm.products.isEmpty
                          ? const Center(
                              child: Text("No hay productos disponibles"),
                            )
                          : ListView.builder(
                              itemCount: vm.products.length,
                              itemBuilder: (context, index) {
                                final product = vm.products[index];
                                return Card(
                                  child: ListTile(
                                    leading: const Icon(Icons.shopping_bag,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                    title: Text(product.nombre),
                                    subtitle: Text(
                                        '${product.precio} CLP — Stock: ${product.stock}'),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              ProductDetail(product: product),
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

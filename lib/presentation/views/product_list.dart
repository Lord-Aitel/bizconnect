import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../presentation/views/product_viewmodel.dart';
//import '../../domain/entities/product.dart';
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

          if (vm.products.isEmpty) {
            return const Scaffold(
              body: Center(child: Text("No hay productos disponibles")),
            );
          }

          return Scaffold(
            appBar: AppBar(title: const Text("Productos")),
            body: ListView.builder(
              itemCount: vm.products.length,
              itemBuilder: (context, index) {
                final product = vm.products[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.shopping_bag, color: Colors.deepPurple),
                    title: Text(product.nombre),
                    subtitle: Text('${product.precio} CLP — Stock: ${product.stock}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetail(product: product),
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

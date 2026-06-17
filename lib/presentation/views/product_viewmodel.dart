import 'package:flutter/material.dart';
import '../../data/sources/firebase_service.dart';
import '../../domain/entities/product.dart';

class ProductViewModel extends ChangeNotifier {
  final FirebaseService _service = FirebaseService();
  List<Product> _products = [];
  List<Map<String, dynamic>> _searchResults = []; // 🔎 productos + local
  bool _loading = false;

  List<Product> get products => _products;
  List<Map<String, dynamic>> get searchResults => _searchResults;
  bool get loading => _loading;

  void listenToProducts(String localId) {
    _loading = true;
    notifyListeners();

    _service.obtenerProductosStream(localId).listen((snapshot) {
      _products = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Product.fromFirestore(doc.id, data);
      }).toList();
      _loading = false;
      notifyListeners();
    }, onError: (e) {
      debugPrint('Error al escuchar productos: $e');
      _loading = false;
      notifyListeners();
    });
  }

  Future<void> addProduct(String localId, Product product) async {
    try {
      await _service.agregarProducto(
        localId,
        product.nombre,
        product.precio,
        product.stock,
        descripcion: product.descripcion,
        imagenUrl: product.imagenUrl,
        rating: product.rating,
      );
    } catch (e) {
      debugPrint('Error al agregar producto: $e');
    }
  }

  // 🔎 Buscar productos SOLO en el local actual
  void searchLocalProducts(String query) {
    if (query.isEmpty) {
      _searchResults = [];
    } else {
      _searchResults = _products
          .where((p) => p.nombre.toLowerCase().contains(query.toLowerCase()))
          .map((p) => {"producto": p, "local": "Este local"})
          .toList();
    }
    notifyListeners();
  }

  // 🔎 Buscar productos en TODOS los locales
  Future<void> searchProducts(String query) async {
    _loading = true;
    notifyListeners();
    try {
      final locales = await _service.getLocalesWithProducts();
      _searchResults = locales.expand<Map<String, dynamic>>((local) {
        return local.productos
            .where((p) => p.nombre.toLowerCase().contains(query.toLowerCase()))
            .map((p) => {"producto": p, "local": local.nombre});
      }).toList();
    } catch (e) {
      debugPrint("Error en búsqueda de productos: $e");
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}

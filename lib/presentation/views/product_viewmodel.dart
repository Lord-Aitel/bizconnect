import 'package:flutter/material.dart';
import '../../data/sources/firebase_service.dart';
import '../../domain/entities/product.dart';

class ProductViewModel extends ChangeNotifier {
  final FirebaseService _service = FirebaseService();
  List<Product> _products = [];
  bool _loading = false;

  List<Product> get products => _products;
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
      );
    } catch (e) {
      debugPrint('Error al agregar producto: $e');
    }
  }
}

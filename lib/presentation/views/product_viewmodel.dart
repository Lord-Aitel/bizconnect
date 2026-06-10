import 'package:flutter/material.dart';
import '../../data/sources/firebase_service.dart';
import '../../domain/entities/product.dart';

class ProductViewModel extends ChangeNotifier {
  final FirebaseService _service = FirebaseService();
  List<Product> _products = [];
  bool _loading = false;

  List<Product> get products => _products;
  bool get loading => _loading;

  Future<void> fetchProducts(String localId) async {
    _loading = true;
    notifyListeners();
    try {
      _products = await _service.getProducts(localId);
    } catch (e) {
      debugPrint('Error al cargar productos: $e');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}

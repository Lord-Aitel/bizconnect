import 'package:flutter/material.dart';
import '../../data/sources/firebase_service.dart';
import '../../domain/entities/local.dart';

class LocalesViewModel extends ChangeNotifier {
  final FirebaseService _service = FirebaseService();
  List<Local> _locales = [];
  bool _loading = false;

  List<Local> get locales => _locales;
  bool get loading => _loading;

  Future<void> fetchLocales() async {
    _loading = true;
    notifyListeners();
    try {
      _locales = await _service.getLocales();
    } catch (e) {
      debugPrint('Error al cargar locales: $e');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}

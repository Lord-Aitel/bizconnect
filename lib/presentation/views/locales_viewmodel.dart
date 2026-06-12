import 'package:flutter/material.dart';
import '../../data/sources/firebase_service.dart';
import '../../domain/entities/local.dart';
import '../../data/sources/local_storage_service.dart';

class LocalesViewModel extends ChangeNotifier {
  final FirebaseService _service = FirebaseService();
  final LocalStorageService _storage = LocalStorageService();

  List<Local> _locales = [];
  List<Local> _filteredLocales = [];
  bool _loading = false;
  String? _lastLocalId;

  
  final String userLocalId = "uid_del_usuario";

  List<Local> get locales => _filteredLocales.isEmpty ? _locales : _filteredLocales;
  bool get loading => _loading;
  String? get lastLocalId => _lastLocalId;

  Future<void> fetchLocales() async {
    _loading = true;
    notifyListeners();
    try {
      _locales = await _service.getLocales();
      _filteredLocales = _locales;
      _lastLocalId = await _storage.getLastLocal();
    } catch (e) {
      debugPrint('Error al cargar locales: $e');
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void listenToLocales() {
    _loading = true;
    notifyListeners();

    _service.obtenerLocalesStream().listen((snapshot) {
      _locales = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Local.fromFirestore(doc.id, data);
      }).toList();

      _filteredLocales = _locales;
      _loading = false;
      notifyListeners();
    }, onError: (e) {
      debugPrint('Error al escuchar locales: $e');
      _loading = false;
      notifyListeners();
    });

    _storage.getLastLocal().then((id) {
      _lastLocalId = id;
      notifyListeners();
    });
  }

  Future<void> setLastLocal(String localId) async {
    await _storage.saveLastLocal(localId);
    _lastLocalId = localId;
    notifyListeners();
  }

  // 🔎 Método de búsqueda
  void searchLocales(String query) {
    if (query.isEmpty) {
      _filteredLocales = _locales;
    } else {
      _filteredLocales = _locales
          .where((local) => local.nombre.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}

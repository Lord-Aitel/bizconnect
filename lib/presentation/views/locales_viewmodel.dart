import 'package:flutter/material.dart';
import '../../data/sources/firebase_service.dart';
import '../../domain/entities/local.dart';
import '../../data/sources/local_storage_service.dart';

class LocalesViewModel extends ChangeNotifier {
  final FirebaseService _service = FirebaseService();
  final LocalStorageService _storage = LocalStorageService();

  List<Local> _locales = [];
  bool _loading = false;
  String? _lastLocalId;

  List<Local> get locales => _locales;
  bool get loading => _loading;
  String? get lastLocalId => _lastLocalId;

  Future<void> fetchLocales() async {
    _loading = true;
    notifyListeners();
    try {
      _locales = await _service.getLocales();

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
}
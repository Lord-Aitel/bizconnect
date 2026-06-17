import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<void> saveLastLocal(String localId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_local', localId);
  }

  Future<String?> getLastLocal() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('last_local');
  }
}

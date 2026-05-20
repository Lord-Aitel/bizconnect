import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 🔹 Prueba de conexión
  Future<void> pruebaConexion() async {
    await _db.collection('test').add({
      'mensaje': 'Conexión exitosa con Firestore!',
      'fecha': FieldValue.serverTimestamp(), // mejor que DateTime.now()
    });
  }

  // 🔹 Agregar producto a un local
  Future<void> agregarProducto(
      String localId, String nombre, int precio, int stock) async {
    await _db
        .collection('Locales') // asegúrate que coincide con tu consola Firebase
        .doc(localId)
        .collection('productos')
        .add({
      'nombre': nombre,   // en minúscula para evitar inconsistencias
      'precio': precio,
      'stock': stock,
      'fecha': FieldValue.serverTimestamp(),
    });
  }

  // 🔹 Obtener productos de un local (stream en tiempo real)
  Stream<QuerySnapshot> obtenerProductos(String localId) {
    return _db
        .collection('Locales')
        .doc(localId)
        .collection('productos')
        .orderBy('fecha', descending: true) // ordena por fecha
        .snapshots();
  }

  // 🔹 Eliminar producto de un local
  Future<void> eliminarProducto(String localId, String productoId) async {
    await _db
        .collection('Locales')
        .doc(localId)
        .collection('productos')
        .doc(productoId)
        .delete();
  }

  // 🔹 Actualizar producto de un local
  Future<void> actualizarProducto(
      String localId, String productoId, Map<String, dynamic> datos) async {
    await _db
        .collection('Locales')
        .doc(localId)
        .collection('productos')
        .doc(productoId)
        .update(datos);
  }
}

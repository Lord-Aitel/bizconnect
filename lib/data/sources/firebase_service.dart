import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/local.dart';


class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> pruebaConexion() async {
    await _db.collection('test').add({
      'mensaje': 'Conexión exitosa con Firestore!',
      'fecha': FieldValue.serverTimestamp(),
    });
  }

  Future<void> agregarProducto(
      String localId, String nombre, int precio, int stock) async {
    await _db
        .collection('Locales')
        .doc(localId)
        .collection('Productos')
        .add({
      'nombre': nombre,
      'precio': precio,
      'stock': stock,
      'fecha': FieldValue.serverTimestamp(),
    });
  }

  Stream<QuerySnapshot> obtenerProductosStream(String localId) {
    return _db
        .collection('Locales')
        .doc(localId)
        .collection('Productos')
        .orderBy('fecha', descending: true)
        .snapshots();
  }

Future<List<Product>> getProducts(String localId) async {
  final snapshot = await _db
      .collection('Locales')
      .doc(localId)
      .collection('Productos')
      .orderBy('fecha', descending: true)
      .get();

  return snapshot.docs.map((doc) {
  final data = doc.data();
  return Product(
    id: doc.id, // ← aquí está el ID real
    nombre: data['nombre'] ?? '',
    precio: data['precio'] ?? 0,
    stock: data['stock'] ?? 0,
  );
  }).toList();
}

  Future<List<Local>> getLocales() async {
    final snapshot = await _db.collection('Locales').get();

    return snapshot.docs
        .map((doc) => Local.fromFirestore(doc.id, doc.data()))
        .toList();
  }


  Future<void> eliminarProducto(String localId, String productoId) async {
    await _db
        .collection('Locales')
        .doc(localId)
        .collection('Productos')
        .doc(productoId)
        .delete();
  }

  Stream<QuerySnapshot> obtenerLocalesStream() {
    return _db.collection('Locales').snapshots();
  }

  Future<void> actualizarProducto(
      String localId, String productoId, Map<String, dynamic> datos) async {
    await _db
        .collection('Locales')
        .doc(localId)
        .collection('Productos')
        .doc(productoId)
        .update(datos);
  }
}

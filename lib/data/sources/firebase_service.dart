import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  Future<void> crearLocal(String localId, String nombre, String descripcion) async {
    await _db.collection('Locales').doc(localId).set({
      'nombre': nombre,
      'descripcion': descripcion,
      'fechaCreacion': FieldValue.serverTimestamp(),
    });
  }

  Future<DocumentSnapshot?> getLocal(String localId) async {
    try {
      final doc = await _db.collection('Locales').doc(localId).get();
      if (doc.exists) return doc;
      return null;
    } catch (e) {
      print('Error al obtener el local: $e');
      return null;
    }
  }

  // 🔹 Agregar producto con descripción, imagen y rating
  Future<void> agregarProducto(
    String localId,
    String nombre,
    double precio,
    int stock, {
    required String descripcion,
    required String imagenUrl,
    required double rating,
  }) async {
    await _db.collection('Locales').doc(localId).collection('Productos').add({
      'nombre': nombre,
      'precio': precio,
      'stock': stock,
      'descripcion': descripcion,
      'imagenUrl': imagenUrl,
      'rating': rating,
      'fecha': FieldValue.serverTimestamp(),
    });
  }

  // 🔹 Versión con subida de imagen a Firebase Storage
  Future<void> agregarProductoConImagen(
    String localId,
    String nombre,
    double precio,
    int stock,
    String descripcion,
    File? imagen,
    double rating,
  ) async {
    String? imageUrl;
    if (imagen != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('Locales/$localId/Productos/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await ref.putFile(imagen);
      imageUrl = await ref.getDownloadURL();
    }

    await _db.collection('Locales').doc(localId).collection('Productos').add({
      'nombre': nombre,
      'precio': precio,
      'stock': stock,
      'descripcion': descripcion,
      'imagenUrl': imageUrl,
      'rating': rating,
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
      return Product.fromFirestore(doc.id, data);
    }).toList();
  }

  Future<List<Local>> getLocales() async {
    final snapshot = await _db.collection('Locales').get();
    return snapshot.docs
        .map((doc) => Local.fromFirestore(doc.id, doc.data()))
        .toList();
  }

  Stream<QuerySnapshot> obtenerLocalesStream() {
    return _db.collection('Locales').snapshots();
  }

  Future<void> eliminarProducto(String localId, String productoId) async {
    await _db
        .collection('Locales')
        .doc(localId)
        .collection('Productos')
        .doc(productoId)
        .delete();
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

  // 🔎 Nuevo método para obtener todos los locales con sus productos
  Future<List<Local>> getLocalesWithProducts() async {
    try {
      final localesSnapshot = await _db.collection('Locales').get();

      final locales = await Future.wait(localesSnapshot.docs.map((localDoc) async {
        final localData = localDoc.data();

        final productosSnapshot = await _db
            .collection('Locales')
            .doc(localDoc.id)
            .collection('Productos')
            .get();

        final productos = productosSnapshot.docs.map((prodDoc) {
          final prodData = prodDoc.data();
          return Product.fromFirestore(prodDoc.id, prodData);
        }).toList();

        return Local.fromFirestore(localDoc.id, {
          ...localData,
          'productos': productos,
        });
      }));

      return locales;
    } catch (e) {
      print('Error al obtener locales con productos: $e');
      return [];
    }
  }
}

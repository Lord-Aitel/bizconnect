import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import '../models/product_model.dart';

class FirebaseService {
  final firestore = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  // Subir imagen a Firebase Storage
  Future<String> uploadImage(File imageFile, String fileName) async {
    final ref = storage.ref().child('products/$fileName');
    await ref.putFile(imageFile);
    return await ref.getDownloadURL();
  }

  // Guardar producto en Firestore
  Future<void> addProduct(Product product) async {
    await firestore.collection('products').add(product.toMap());
  }

  // Obtener lista de productos
  Future<List<Product>> fetchProducts() async {
    final snapshot = await firestore.collection('products').get();
    return snapshot.docs
        .map((doc) => Product.fromMap(doc.data(), doc.id))
        .toList();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String nombre;
  final double precio;
  final int stock;
  final String descripcion;
  final String imagenUrl;
  final String imagenLocal;
  final double rating;
  final DateTime fecha;

  Product({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.stock,
    required this.descripcion,
    required this.imagenUrl,
    required this.imagenLocal,
    required this.rating,
    required this.fecha,
  });

  factory Product.fromFirestore(String id, Map<String, dynamic> data) {
    return Product(
      id: id,
      nombre: data['nombre'] ?? '',
      precio: (data['precio'] ?? 0).toDouble(),
      stock: data['stock'] ?? 0,
      descripcion: data['descripcion'] ?? '',
      imagenUrl: data['imagenUrl'] ?? '',
      imagenLocal: data['imagenLocal'] ?? '',
      rating: (data['rating'] ?? 0).toDouble(),
      fecha: (data['fecha'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'precio': precio,
      'stock': stock,
      'descripcion': descripcion,
      'imagenUrl': imagenUrl,
      'imagenLocal': imagenLocal,
      'rating': rating,
      'fecha': fecha,
    };
  }
}

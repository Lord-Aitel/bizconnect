import 'product.dart';

class Local {
  final String id;
  final String nombre;
  final String descripcion;
  final List<Product> productos; // 🔹 lista de productos del local

  Local({
    required this.id,
    required this.nombre,
    this.descripcion = '',
    this.productos = const [],
  });

  factory Local.fromFirestore(String id, Map<String, dynamic> data) {
    return Local(
      id: id,
      nombre: data['Nombre'] ?? data['nombre'] ?? '',
      descripcion: data['descripcion'] ?? '',
      productos: (data['productos'] as List?)?.cast<Product>() ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'productos': productos.map((p) => p.toMap()).toList(),
    };
  }
}

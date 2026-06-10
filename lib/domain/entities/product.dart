class Product {
  final String id;
  final String nombre;
  final int precio;
  final int stock;

  Product({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.stock,
  });

  // 🔹 Constructor desde Firestore
  factory Product.fromFirestore(Map<String, dynamic> data) {
    return Product(
      id: data['id'] ?? '',
      nombre: data['nombre'] ?? '',
      precio: data['precio'] ?? 0,
      stock: data['stock'] ?? 0,
    );
  }

  // 🔹 Convertir a Map (útil para guardar/actualizar)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'precio': precio,
      'stock': stock,
    };
  }
}

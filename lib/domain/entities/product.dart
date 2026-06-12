class Product {
  final String id;
  final String nombre;
  final double precio;
  final int stock;
  final String descripcion;
  final String imagenUrl;
  final double rating; // de 0 a 5

  Product({
    required this.id,
    required this.nombre,
    required this.precio,
    required this.stock,
    required this.descripcion,
    required this.imagenUrl,
    required this.rating,
  });

  // 🔹 Constructor desde Firestore
  factory Product.fromFirestore(String id, Map<String, dynamic> data) {
    return Product(
      id: id,
      nombre: data['nombre'] ?? '',
      precio: (data['precio'] ?? 0).toDouble(),
      stock: data['stock'] ?? 0,
      descripcion: data['descripcion'] ?? '',
      imagenUrl: data['imagenUrl'] ?? '',
      rating: (data['rating'] ?? 0).toDouble(),
    );
  }

  // 🔹 Para guardar en Firestore
  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'precio': precio,
      'stock': stock,
      'descripcion': descripcion,
      'imagenUrl': imagenUrl,
      'rating': rating,
    };
  }
}

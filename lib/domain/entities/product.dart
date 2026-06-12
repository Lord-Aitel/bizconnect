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


  factory Product.fromFirestore(String id, Map<String, dynamic> data) {
    return Product(
      id: id,
      nombre: data['nombre'] ?? '',
      precio: data['precio'] ?? 0,
      stock: data['stock'] ?? 0,
    );
  }
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'precio': precio,
      'stock': stock,
    };
  }
}

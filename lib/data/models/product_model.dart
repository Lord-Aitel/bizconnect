class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String seller;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.seller,
  });

  // Crear objeto Product desde Firestore
  factory Product.fromMap(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] is int)
          ? (data['price'] as int).toDouble()
          : (data['price'] ?? 0.0),
      imageUrl: data['imageUrl'] ?? '',
      seller: data['seller'] ?? '',
    );
  }

  // Convertir objeto Product a Map (para guardar en Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'seller': seller,
    };
  }
}

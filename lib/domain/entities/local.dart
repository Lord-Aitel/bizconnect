class Local {
  final String id;
  final String nombre;

  Local({
    required this.id,
    required this.nombre,
  });

  factory Local.fromFirestore(String id, Map<String, dynamic> data) {
    return Local(
      id: id,
      nombre: data['Nombre'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }
}

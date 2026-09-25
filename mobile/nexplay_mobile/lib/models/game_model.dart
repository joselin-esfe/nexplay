class GameModel {
  final int id;
  final String nombre;
  final String descripcion;
  final String dificultad;
  final String? imagenUrl;
  final int categoriaId;
  final String? categoriaNombre;

  GameModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.dificultad,
    this.imagenUrl,
    required this.categoriaId,
    this.categoriaNombre,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'] ?? json['idJuego'] ?? 0,
      nombre: json['nombre'] ?? json['titulo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      dificultad: json['dificultad'] ?? 'Normal',
      imagenUrl: json['imagenUrl'] ?? json['urlImagen'] ?? json['imagen'],
      categoriaId: json['categoriaId'] ?? json['idCategoria'] ?? 0,
      categoriaNombre: json['categoriaNombre'] ?? json['categoria']?['nombre'],
    );
  }
}

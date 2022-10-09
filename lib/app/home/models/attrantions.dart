class Attraction {
  Attraction({
    required this.id,
    required this.nombre,
    required this.latitud,
    required this.longitud,
    required this.socialUrl,
    required this.descripcion,
    required this.imageUrls,
    required this.tieneHospedaje,
    required this.tieneTurismo,
    required this.tieneAlimentacion,
  });
  final String id;
  final String nombre;
  final double latitud;
  final double longitud;
  final String socialUrl;
  final String descripcion;
  final List<String> imageUrls;
  final bool tieneHospedaje;
  final bool tieneTurismo;
  final bool tieneAlimentacion;
}

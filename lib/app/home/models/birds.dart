class Bird {
  Bird(
      {required this.id,
      required this.nombreCientifico,
      required this.nombreComun,
      required this.imageUrl,
      required this.avistadoEn,
      required this.isRepresentative,
      required this.familia,
      required this.memotecnia,
      required this.nombreIngles,
      required this.status,
      required this.tamano,
      required this.alimentacion,
      required this.habitat,
      required this.altitud,
      required this.paises});
  final int id;
  final String nombreCientifico;
  final String nombreComun;
  final String imageUrl;
  final List<String> avistadoEn;
  final bool isRepresentative;
  final String familia;
  final String memotecnia;
  final String nombreIngles;
  final String status;
  final String tamano;
  final String alimentacion;
  final String habitat;
  final String altitud;
  final List<String> paises;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombreCientifico': nombreCientifico,
      'nombreComun': nombreComun,
      'imageUrl': imageUrl,
      'avistadoEn': avistadoEn,
      'isRepresentative': isRepresentative,
      'familia': familia,
      'memotecnia': memotecnia,
      'nombreIngles': nombreIngles,
      'status': status,
      'tamano': tamano,
      'alimentacion': alimentacion,
      'habitat': habitat,
      'altitud': altitud,
      'paises': paises
    };
  }
}

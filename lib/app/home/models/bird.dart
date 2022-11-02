class Bird {
  Bird(
      {required this.cantoUrl,
      required this.id,
      required this.nombreCientifico,
      required this.nombreComun,
      required this.imageUrl,
      required this.avistadoEn,
      required this.esRepresentativa,
      required this.familia,
      required this.memotecnia,
      required this.nombreIngles,
      required this.status,
      required this.tamano,
      required this.alimentacion,
      required this.habitat,
      required this.altitud,
      required this.paises});
  final String id;
  final String nombreCientifico;
  final String nombreComun;
  final List<String> imageUrl;
  final List<String> avistadoEn;
  final bool esRepresentativa;
  final String familia;
  final String memotecnia;
  final String nombreIngles;
  final String status;
  final String tamano;
  final String alimentacion;
  final String habitat;
  final String altitud;
  final List<String> paises;
  final String cantoUrl;

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombreCientifico': nombreCientifico,
        'nombreComun': nombreComun,
        'imageUrl': imageUrl,
        'avistadoEn': avistadoEn,
        'isRepresentative': esRepresentativa,
        'familia': familia,
        'memotecnia': memotecnia,
        'nombreIngles': nombreIngles,
        'status': status,
        'tamano': tamano,
        'alimentacion': alimentacion,
        'habitat': habitat,
        'altitud': altitud,
        'paises': paises,
        'cantoUrl': cantoUrl,
      };

  static Bird fromJson(Map<String, dynamic> json) => Bird(
        cantoUrl: json['cantoUrl'],
        id: json['id'],
        nombreCientifico: json['nombreCientifico'],
        nombreComun: json['nombreComun'],
        imageUrl: List.from(json['imageUrl']),
        avistadoEn: List.from(json['avistadoEn']),
        esRepresentativa: json['esRepresentativa'],
        familia: json['familia'],
        memotecnia: json['memotecnia'],
        nombreIngles: json['nombreIngles'],
        status: json['status'],
        tamano: json['tamano'],
        alimentacion: json['alimentacion'],
        habitat: json['habitat'],
        altitud: json['altitud'],
        paises: List.from(json['paises']),
      );
}

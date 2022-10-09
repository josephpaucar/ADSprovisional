class Bird {
  final int id;
  final String nombreCientifico;
  final String nombreComun;
  final String imageUrl;
  final List<int> avistadoEn;
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

  Bird(
    this.id,
    this.nombreCientifico,
    this.nombreComun,
    this.imageUrl,
    this.avistadoEn,
    this.isRepresentative,
    this.familia,
    this.memotecnia,
    this.nombreIngles,
    this.status,
    this.tamano,
    this.alimentacion,
    this.habitat,
    this.altitud,
    this.paises,
  );

  static final birds = [
    Bird(
      1,
      'Ortalis guttata',
      'Chachalaca Jaspeada',
      'assets/images/ave-ejemplo.jpg',
      [1, 2],
      true,
      'CRACIDAE',
      "cha-cha'LAH-kah!",
      'Speckled Chachalaca',
      'Residente',
      '49.5-52 cm',
      'Se alimenta de semillas y frutos.',
      'Se encuentra en el borde del bosque primario y bosques ribereños de la amazonia',
      'hasta los 1700 metros',
      ['Co', 'E', 'Br', 'Bo'],
    ),
    Bird(
      2,
      'Cathartes aura',
      'Gallinazo de Cabeza Roja',
      'assets/images/gallito-de-las-rocas.webp',
      [1, 2],
      false,
      'CATHARTIDAE',
      "",
      'Turkey Vulture',
      'Residente',
      '60-70 cm',
      'Tiene un olfato muy desarrollado, su prcincipal alimento es animales muertos y comidas que se encuentra en la basura',
      'Habita en zonas abiertas matorrales, savanas y desiertos.',
      'hasta los 2200 metros',
      ['Co', 'E', 'Br', 'Bo', 'Ch'],
    ),
  ];
}

class Event {
  final int id;
  final String nombre;
  final String imageUrl;
  final String webUrl;

  Event(this.id, this.nombre, this.imageUrl, this.webUrl);

  static final events = [
    Event(1, 'Evento de la semana en Altomayo',
        'assets/images/evento-ejemplo.jpg', 'https://google.com'),
    Event(2, 'Evento en ciudad de  Madre de Dios',
        'assets/images/evento-ejemplo2.jpg', 'https://google.com'),
    Event(3, 'Evento de la semana en Altomayo',
        'assets/images/evento-ejemplo.jpg', 'https://google.com'),
    Event(4, 'Evento en ciudad de Madre de Dios',
        'assets/images/evento-ejemplo2.jpg', 'https://google.com'),
    Event(5, 'Evento de la semana en Altomayo',
        'assets/images/evento-ejemplo.jpg', 'https://google.com'),
    Event(6, 'Evento en ciudad de Madre de Dios',
        'assets/images/evento-ejemplo2.jpg', 'https://google.com'),
  ];
}

class AttractionService {
  final int id;
  final String name;
  final String imageUrl;
  final String category;
  final int inAttraction;

  AttractionService(
      this.id, this.name, this.imageUrl, this.category, this.inAttraction);

  static final attractionService = [
    AttractionService(1, 'Servicio de alojamiento',
        'assets/images/evento-ejemplo.jpg', 'hospedaje', 1),
    AttractionService(1, 'Servicio de turismo',
        'assets/images/evento-ejemplo2.jpg', 'turismo', 1),
    AttractionService(1, 'Servicio de alojamiento',
        'assets/images/evento-ejemplo.jpg', 'hospedaje', 2),
    AttractionService(1, 'Servicio de turismo',
        'assets/images/evento-ejemplo2.jpg', 'turismo', 2),
    AttractionService(1, 'Servicio de alojamiento',
        'assets/images/evento-ejemplo.jpg', 'hospedaje', 3),
  ];
}

class Service {
  final int id;
  final String nombre;
  final String imageUrl;
  final bool esDestacado;
  final String categoria;
  final String sitioUrl;
  final String destino;

  Service(
    this.id,
    this.nombre,
    this.imageUrl,
    this.esDestacado,
    this.categoria, //hospedaje, alimentacion o turismo
    this.sitioUrl,
    this.destino,
  );

  static final services = [
    Service(
        1,
        'Evento de la semana en Altomayo',
        'assets/images/evento-ejemplo.jpg',
        true,
        'hospedaje',
        'https://facebook.com',
        'tarapoto'),
    Service(
        2,
        'Evento de la semana en Altomayo',
        'assets/images/evento-ejemplo.jpg',
        true,
        'alimentacion',
        'https://facebook.com',
        'altomayo'),
    Service(
        3,
        'Evento de la semana en Altomayo',
        'assets/images/evento-ejemplo.jpg',
        true,
        'turismo',
        'https://facebook.com',
        'tarapoto'),
  ];
}

class Comment {
  final int id;
  final int postId;
  final User user;
  final String commentContent;
  final String createdTime;

  Comment(
      this.id, this.postId, this.user, this.commentContent, this.createdTime);

  static final comments = [
    Comment(
        1,
        Post.posts[0].id,
        User.users[0],
        'Tempor amet duis officia dolore laboris voluptate cupidatat esse Lorem velit.',
        '1hr'),
    Comment(2, Post.posts[0].id, User.users[1],
        'Aute minim consectetur elit ad eu et exercitation et magna.', '2hr'),
    Comment(3, Post.posts[0].id, User.users[2],
        'Est occaecat elit velit sint anim.', '2set'),
    Comment(
        4,
        Post.posts[1].id,
        User.users[3],
        'Elit nostrud deserunt nisi irure amet consectetur do irure proident anim esse irure commodo ea.',
        '4hr'),
    Comment(5, Post.posts[1].id, User.users[4],
        'Est irure laboris aliquip elit.', '17hr'),
    Comment(
        6,
        Post.posts[1].id,
        User.users[5],
        'Reprehenderit laborum enim duis ex dolor cupidatat anim mollit pariatur exercitation reprehenderit cupidatat.',
        '1oct'),
    Comment(7, Post.posts[1].id, User.users[1],
        'Amet laboris dolore ea irure nisi tempor.', '15set'),
    Comment(8, Post.posts[2].id, User.users[0],
        'Aute exercitation laborum reprehenderit velit sunt magna.', '5oct'),
    Comment(
        9,
        Post.posts[2].id,
        User.users[2],
        'Sint ipsum magna adipisicing eiusmod ex tempor sit adipisicing laborum laboris ad.',
        '4hr'),
    Comment(10, Post.posts[3].id, User.users[4],
        'Duis sit esse eiusmod nisi ut.', '8hr'),
    Comment(
        11,
        Post.posts[3].id,
        User.users[5],
        'Ex officia ut aute cupidatat velit laboris magna Lorem do fugiat aliquip quis magna quis.',
        '6set'),
    Comment(
        12, Post.posts[3].id, User.users[3], 'Est qui ad nulla ad.', '28set'),
    Comment(
        13,
        Post.posts[3].id,
        User.users[1],
        'Esse consectetur qui deserunt cillum mollit nostrud elit veniam sit proident voluptate Lorem ullamco eu.',
        '2oct'),
    Comment(14, Post.posts[3].id, User.users[0],
        'Laboris labore nisi dolore culpa cillum laborum.', '37min'),
    Comment(
        15,
        Post.posts[4].id,
        User.users[2],
        'Et ut id Lorem non nostrud exercitation est laborum aliquip eu.',
        '15min'),
    Comment(16, Post.posts[4].id, User.users[3], 'Labore nisi non duis quis.',
        '1min'),
    Comment(17, Post.posts[4].id, User.users[5],
        'Duis ut consectetur ex voluptate aute irure voluptate.', '9hr'),
    Comment(18, Post.posts[0].id, User.users[4],
        'Est officia ut pariatur qui elit laboris do.', '17set'),
  ];
}

class User {
  final int userId;
  final String name;
  final String lastName;
  final String userInitials;

  User(this.userId, this.name, this.lastName, this.userInitials);

  static final users = [
    User(1, 'Joseph', 'Paucar', 'JP'),
    User(2, 'Oscar', 'Chirinos', 'OC'),
    User(3, 'Angie', 'Paucar', 'AP'),
    User(4, 'Rafael', 'Paucar', 'RP'),
    User(5, 'Maria', 'Cruz', 'MC'),
    User(6, 'Juan', 'Cruz', 'JC'),
  ];
}

class Post {
  final int id;
  final String imageUrl;
  final String title;
  final String description;
  final int totalComments;
  final int totalLikes;
  final User user;
  final int tomadoEn;

  Post(
    this.id,
    this.imageUrl,
    this.title,
    this.description,
    this.totalComments,
    this.totalLikes,
    this.user,
    this.tomadoEn,
  );

  static final posts = [
    Post(
        1,
        'assets/images/post-ejemplo.jpg',
        'Gallito de las Rocas',
        'Encontramos un hermoso Gallito de las Rocas en la ruta 1',
        12,
        33,
        User.users[0],
        1),
    Post(
        2,
        'assets/images/post-ejemplo.jpg',
        'Gallito de las Rocas 1',
        'Encontramos un hermoso Gallito de las Rocas en la ruta 1',
        12,
        33,
        User.users[0],
        2),
    Post(
        3,
        'assets/images/post-ejemplo.jpg',
        'Gallito de las Rocas 2',
        'Encontramos un hermoso Gallito de las Rocas en la ruta 1',
        12,
        33,
        User.users[1],
        1),
    Post(
        4,
        'assets/images/post-ejemplo.jpg',
        'Gallito de las Rocas 3',
        'Encontramos un hermoso Gallito de las Rocas en la ruta 1',
        12,
        33,
        User.users[2],
        3),
    Post(
        5,
        'assets/images/post-ejemplo.jpg',
        'Gallito de las Rocas 4',
        'Encontramos un hermoso Gallito de las Rocas en la ruta 1',
        12,
        33,
        User.users[3],
        2),
  ];
}

class Ruta {
  final int id;
  final String name;
  final List<Attraction> attractionsList;

  Ruta(this.id, this.name, this.attractionsList);

  static final rutas = [
    Ruta(1, 'Ruta con 2 Atractivos',
        [Attraction.attractoins[0], Attraction.attractoins[1]]),
    Ruta(1, 'Ruta con 3 Atractivos', [
      Attraction.attractoins[2],
      Attraction.attractoins[3],
      Attraction.attractoins[4]
    ]),
    Ruta(1, 'Ruta con 3 Atractivos', [
      Attraction.attractoins[5],
      Attraction.attractoins[6],
      Attraction.attractoins[7]
    ]),
    Ruta(1, 'Ruta con 1 Atractivos', [Attraction.attractoins[8]])
  ];
}

class Attraction {
  final int id;
  final String name;
  final double latitud;
  final double longitud;
  final String socialUrl;
  final String shortDescription;
  final List<String> imageUrls;
  final bool tieneHospedaje;
  final bool tieneTurismo;
  final bool tieneAlimentacion;

  Attraction(
    this.id,
    this.name,
    this.latitud,
    this.longitud,
    this.socialUrl,
    this.shortDescription,
    this.tieneHospedaje,
    this.tieneTurismo,
    this.tieneAlimentacion,
    this.imageUrls,
  );

  static final attractoins = [
    Attraction(
      1,
      'Cataratas de Sabaloyacu',
      -6.4022795,
      -76.2834683,
      'https://facebook.com',
      'Magna nulla proident consequat irure labore laboris minim dolore et laborum veniam veniam velit. Deserunt id nostrud fugiat duis irure deserunt culpa sit excepteur ad do cupidatat. Magna voluptate laboris sit est qui nostrud mollit ex mollit officia ut.',
      true,
      true,
      true,
      ['Cataratas-de-Sabaloyacu-1.jpg', 'Cataratas-de-Sabaloyacu-2.png'],
    ),
    Attraction(
      2,
      'Cataratas de Sabaloyacu',
      -6.4022795,
      -76.2834683,
      'https://facebook.com',
      'Magna nulla proident consequat irure labore laboris minim dolore et laborum veniam veniam velit. Deserunt id nostrud fugiat duis irure deserunt culpa sit excepteur ad do cupidatat. Magna voluptate laboris sit est qui nostrud mollit ex mollit officia ut.',
      true,
      true,
      false,
      ['Cataratas-de-Sabaloyacu-1.jpg', 'Cataratas-de-Sabaloyacu-2.png'],
    ),
    Attraction(
      3,
      'Cataratas de Sabaloyacu',
      -6.4022795,
      -76.2834683,
      'https://facebook.com',
      'Magna nulla proident consequat irure labore laboris minim dolore et laborum veniam veniam velit. Deserunt id nostrud fugiat duis irure deserunt culpa sit excepteur ad do cupidatat. Magna voluptate laboris sit est qui nostrud mollit ex mollit officia ut.',
      true,
      true,
      false,
      ['Cataratas-de-Sabaloyacu-1.jpg', 'Cataratas-de-Sabaloyacu-2.png'],
    ),
  ];
}

class Recomendation {
  final int id;
  final String description;
  final String category;

  Recomendation(this.id, this.description, this.category);

  static final recomendations = [
    Recomendation(1, 'Minim eu amet occaecat amet dolore officia ex.', 'home'),
    Recomendation(2, 'Ad ut dolore officia incididunt.', 'servicios'),
    Recomendation(
        3,
        'Fugiat qui irure cupidatat consequat sint exercitation deserunt est ut et in laboris laborum.',
        'home'),
    Recomendation(4, 'Exercitation sunt laborum eu consectetur.', 'servicios'),
    Recomendation(
        5,
        'Exercitation ullamco fugiat id quis labore velit excepteur sit cillum adipisicing.',
        'servicios'),
    Recomendation(6, 'In qui id dolor non.', 'home')
  ];
}

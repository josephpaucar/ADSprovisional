import 'package:flutter/material.dart';

class HomeEventCard extends StatelessWidget {
  final String imageUrl;
  final String nombre;

  const HomeEventCard({
    Key? key,
    required this.imageUrl,
    required this.nombre,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(right: 12),
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          _Image(
            iu: imageUrl,
          ),
          const _Header(),
          _Footer(
            nm: nombre,
          )
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 5,
      left: 5,
      child: CircleAvatar(
        radius: 15,
        backgroundColor: Color(0xFF396A1E),
        foregroundColor: Colors.white,
        child: Text(
          'E',
          style: TextStyle(fontFamily: 'Pacifico', fontSize: 13),
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  final String iu;

  const _Image({
    Key? key,
    required this.iu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink.image(
      image: const AssetImage('assets/images/evento-ejemplo2.jpg'),
      height: 220,
      width: 170,
      fit: BoxFit.cover,
      child: InkWell(
        onTap: () {},
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final String nm;
  const _Footer({
    Key? key,
    required this.nm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      child: Container(
        width: 150,
        color: Colors.black26.withOpacity(0.2),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Text(
          nm,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ),
      ),
    );
  }
}

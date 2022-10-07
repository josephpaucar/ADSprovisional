import 'package:flutter/material.dart';

class BirdCardStyle3 extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String nombreCientifico;
  final String nombreComun;

  const BirdCardStyle3({
    Key? key,
    required this.imageUrl,
    required this.nombreCientifico,
    required this.nombreComun,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          Ink.image(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () {},
            ),
          ),
          _Footer(
            nm: nombreComun,
            nc: nombreCientifico,
          )
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final String nm;
  final String nc;
  const _Footer({
    Key? key,
    required this.nm,
    required this.nc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      child: Container(
        color: Colors.black26.withOpacity(0.2),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Column(
          children: [
            Text(
              nc,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            Text(
              nm,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class EventCardStyle2 extends StatelessWidget {
  final String imageUrl;
  final String nombre;

  const EventCardStyle2({
    Key? key,
    required this.imageUrl,
    required this.nombre,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 1,
      margin: const EdgeInsets.only(right: 12),
      child: Stack(
        children: [
          Ink.image(
            image: AssetImage(imageUrl),
            height: 220,
            width: 170,
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () {},
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 150,
              color: Colors.black26.withOpacity(0.2),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Text(
                nombre,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

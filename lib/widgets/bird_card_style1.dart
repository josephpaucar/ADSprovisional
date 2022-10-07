import 'package:flutter/material.dart';

class BirdCardStyle1 extends StatelessWidget {
  final String nombreCientifico;
  final String nombreComun;
  final String description;
  final String imageUrl;
  final int id;

  const BirdCardStyle1({
    Key? key,
    required this.nombreCientifico,
    required this.nombreComun,
    required this.description,
    required this.imageUrl,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const _Background(),
          _Image(
            iu: imageUrl,
          ),
          _CardInfo(nct: nombreCientifico, ncm: nombreComun, dsc: description),
          _Button(
            index: id,
          )
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final int index;
  const _Button({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 8,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF396A1E)),
          child: const Text(
            'Saber más',
            style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
          ),
          onPressed: () {},
        ));
  }
}

class _CardInfo extends StatelessWidget {
  final String nct;
  final String ncm;
  final String dsc;
  const _CardInfo({
    Key? key,
    required this.nct,
    required this.ncm,
    required this.dsc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 4,
        top: 4,
        child: Container(
          width: 125,
          height: 242,
          decoration: BoxDecoration(
            color: const Color(0xFF9B442B).withOpacity(0.3),
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  nct,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  ncm,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  dsc,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ));
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
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 250,
        width: 250,
        decoration: BoxDecoration(
            image: DecorationImage(fit: BoxFit.cover, image: AssetImage(iu))),
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

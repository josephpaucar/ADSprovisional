import 'package:flutter/material.dart';

class BirdCardStyle2 extends StatelessWidget {
  const BirdCardStyle2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: const [
            Expanded(flex: 1, child: _Image()),
            Expanded(flex: 1, child: _CardInfo())
          ],
        ),
      ),
    );
  }
}

class _CardInfo extends StatelessWidget {
  const _CardInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 12, left: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Nombre Científico",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w500),
            ),
            const Text(
              "Nombre común",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Lato',
                  fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 10),
            const Text(
              "Lorem ipsum dolor sit amet, consectetur adipising elit.",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Lato',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF396A1E),
                  textStyle: const TextStyle(fontSize: 14)),
              child: const Text(
                'Saber más',
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/ave-ejemplo.jpg'))),
    );
  }
}

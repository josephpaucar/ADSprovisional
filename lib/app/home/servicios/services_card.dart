import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ServicesCard extends StatefulWidget {
  final String destino;
  final String nombre;
  final String imageUrl;
  final String webUrl;

  const ServicesCard({
    Key? key,
    required this.destino,
    required this.nombre,
    required this.imageUrl,
    required this.webUrl,
  }) : super(key: key);

  @override
  State<ServicesCard> createState() => _ServicesCardState();
}

class _ServicesCardState extends State<ServicesCard> {
  Future<void>? _launched;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

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
            image: NetworkImage(widget.imageUrl),
            height: 220,
            width: 170,
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () async {
                final uri = Uri.parse(widget.webUrl);
                setState(() {
                  _launched = _launchInBrowser(uri);
                });
              },
            ),
          ),
          Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 75,
                color: const Color(0xFF396A1E),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Text(widget.destino,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    )),
              )),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: 150,
              color: Colors.black26.withOpacity(0.2),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: Text(
                widget.nombre,
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

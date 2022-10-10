import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeEventCard extends StatefulWidget {
  final String imageUrl;
  final String nombre;
  final String siteUrl;

  const HomeEventCard({
    Key? key,
    required this.imageUrl,
    required this.nombre,
    required this.siteUrl,
  }) : super(key: key);

  @override
  State<HomeEventCard> createState() => _HomeEventCardState();
}

class _HomeEventCardState extends State<HomeEventCard> {
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
      margin: const EdgeInsets.only(right: 12),
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          Ink.image(
            image: NetworkImage(widget.imageUrl),
            height: 220,
            width: 170,
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () async {
                final uri = Uri.parse(widget.siteUrl);
                setState(() {
                  _launched = _launchInBrowser(uri);
                });
              },
            ),
          ),
          const _Header(),
          _Footer(
            nm: widget.nombre,
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
      right: 0,
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

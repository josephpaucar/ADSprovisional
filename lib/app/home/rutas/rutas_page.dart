import 'package:aves_de_san_martin/app/home/rutas/rutas_controller.dart';
import 'package:aves_de_san_martin/services/firestore_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'all_birds_in_attraction_page.dart';
import 'all_posts_in_attraction_page.dart';

class RutasPage extends StatefulWidget {
  const RutasPage({super.key});

  @override
  State<RutasPage> createState() => _RutasPageState();
}

class _RutasPageState extends State<RutasPage> {
  final _controller = RutasController();

  @override
  Widget build(BuildContext context) {
    Widget buildMarkers(BuildContext context) {
      return StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection("attraction").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return GoogleMap(
              initialCameraPosition: _controller.initialCameraPosition,
              myLocationButtonEnabled: true,
              onMapCreated: _controller.onMapCreated,
              compassEnabled: false,
              markers: snapshot.data!.docs.map((document) {
                return Marker(
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          context: context,
                          builder: (builder) {
                            return _BottomSheet(
                              id: document['id'],
                              description: document['descripcion'],
                              title: document['nombre'],
                              tieneHospedaje: document['tieneHospedaje'],
                              tieneTurismo: document['tieneTurismo'],
                              tieneAlimentacion: document['tieneAlimentacion'],
                              imageUrl: document['imageUrl'],
                              avesEnlaZona: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AllBirdsInAttractionPage(
                                            attractionId: document['id'],
                                            attractionName: document['nombre'],
                                          )),
                                );
                              },
                              fotosEnlaZona: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AllPostsInAttractionPage(
                                            attractionId: document['id'],
                                            attractionName: document['nombre'],
                                          )),
                                );
                              },
                              phone: document['telefono'],
                              socialUrl: document['socialUrl'],
                            );
                          });
                    },
                    markerId: MarkerId(document['nombre']),
                    infoWindow: InfoWindow(title: document['nombre']),
                    icon: BitmapDescriptor.defaultMarkerWithHue(13),
                    position:
                        LatLng(document['latitud'], document['longitud']));
              }).toSet(),
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'North Amazonian Birds Peru',
            style: TextStyle(fontFamily: 'BreePeru'),
          ),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: buildMarkers(context),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
              )
            ],
          ),
        ));
  }
}

class _BottomSheet extends StatefulWidget {
  const _BottomSheet({
    Key? key,
    required this.title,
    required this.description,
    required this.id,
    required this.tieneHospedaje,
    required this.tieneTurismo,
    required this.tieneAlimentacion,
    required this.avesEnlaZona,
    required this.fotosEnlaZona,
    required this.imageUrl,
    required this.phone,
    required this.socialUrl,
  }) : super(key: key);

  final String id;
  final String title;
  final String description;
  final bool tieneHospedaje;
  final bool tieneTurismo;
  final bool tieneAlimentacion;
  final VoidCallback avesEnlaZona;
  final VoidCallback fotosEnlaZona;
  final imageUrl;
  final String phone;
  final String socialUrl;

  @override
  State<_BottomSheet> createState() => _BottomSheetState();
}

class _BottomSheetState extends State<_BottomSheet> {
  Future<void>? launched;
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  double initialRate(rates) {
    double sum = 0;
    double currentRaiting = 0;
    for (var i = 0; i < rates.length; i++) {
      sum += rates[i].toDouble();
    }
    double d = sum / rates.length;
    String inString = d.toStringAsFixed(1);
    currentRaiting = double.parse(inString);
    return currentRaiting;
  }

  @override
  Widget build(BuildContext context) {
    Widget makeDismissible({required Widget child}) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(context).pop(),
          child: GestureDetector(
            onTap: () {},
            child: child,
          ),
        );

    return makeDismissible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.5,
        maxChildSize: 0.65,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(controller: controller, children: [
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 120,
                  height: 8,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(4.0),
                        bottomRight: Radius.circular(4.0),
                      )),
                )),
            const SizedBox(height: 16),
            Text(widget.title,
                textAlign: TextAlign.left,
                style: const TextStyle(fontFamily: 'BreePeru', fontSize: 16)),
            const SizedBox(height: 4),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('attraction')
                    .where('id', isEqualTo: widget.id)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child:
                          SizedBox(height: 2, child: LinearProgressIndicator()),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text('An error ocurred.'));
                  }
                  return Row(
                    children: [
                      RatingBar.builder(
                        initialRating:
                            initialRate(snapshot.data!.docs[0].data()['rates']),
                        itemSize: 20,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.only(right: 6),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                          'Raiting ${initialRate(snapshot.data!.docs[0].data()['rates'])}'),
                      const SizedBox(
                        width: 5,
                      ),
                      TextButton(
                          onPressed: snapshot.data!.docs[0]
                                  .data()['ratedBy']
                                  .contains(
                                      FirebaseAuth.instance.currentUser!.uid)
                              ? null
                              : () => showRaiting(widget.id),
                          child: const Text('Calificar',
                              style: TextStyle(fontFamily: 'Poppins'))),
                    ],
                  );
                }),
            const SizedBox(height: 4),
            Text(widget.description,
                textAlign: TextAlign.left,
                style: const TextStyle(fontFamily: 'Poppins', fontSize: 13)),
            const SizedBox(height: 12),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                    color: Colors.black87, fontFamily: 'Poppins'),
                children: [
                  const TextSpan(
                      text: 'Puedes reservar comunicandote al: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: widget.phone,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const Text('Visitanos en: ',
                    style: TextStyle(
                        color: Colors.black87,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold)),
                TextButton(
                    onPressed: () async {
                      final uri = Uri.parse(widget.socialUrl);
                      setState(() {
                        launched = _launchInBrowser(uri);
                      });
                    },
                    child: const Text(
                      'Web Site',
                      style: TextStyle(fontFamily: 'Poppins'),
                    ))
              ],
            ),
            const Text(
              'Servicios que ofrecemos:',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                if (widget.tieneHospedaje == true)
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.hotel_rounded,
                          color: Color(0xFF9B442B),
                        ),
                        Text('Hospedaje',
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: 12))
                      ]),
                const SizedBox(
                  width: 8,
                ),
                if (widget.tieneTurismo == true)
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.emoji_people,
                          color: Color(0xFF9B442B),
                        ),
                        Text('Orientadores locales',
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: 12))
                      ]),
                const SizedBox(
                  width: 8,
                ),
                if (widget.tieneAlimentacion == true)
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.restaurant_rounded,
                          color: Color(0xFF9B442B),
                        ),
                        Text('Alimentacion',
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: 12))
                      ])
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.imageUrl.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Image(
                        image: NetworkImage(widget.imageUrl[index]),
                        height: 200,
                        width: 260,
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton(
                  onPressed: widget.avesEnlaZona,
                  child: const Text(
                    'Aves en la zona',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
                const SizedBox(width: 6),
                ElevatedButton(
                  onPressed: widget.fotosEnlaZona,
                  child: const Text('Fotos en la zona',
                      style: TextStyle(fontFamily: 'Poppins')),
                )
              ],
            ),
            const SizedBox(height: 12),
          ]),
        ),
      ),
    );
  }

  void showRaiting(attractionid) {
    double getRating = 0;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Dale una Puntuación al atractivo.'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Por favor, dejanos una puntuación.',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
              const SizedBox(height: 16),
              RatingBar.builder(
                initialRating: 5,
                itemSize: 30,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.only(right: 6),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) => getRating = rating,
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await FirestoreMethods().attractionRating(
                    attractionid,
                    getRating,
                    FirebaseAuth.instance.currentUser!.uid,
                  );
                  setState(() {});
                },
                child: const Text('Ok',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    )))
          ],
        );
      },
    );
  }
}

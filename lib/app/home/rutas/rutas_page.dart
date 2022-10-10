import 'package:aves_de_san_martin/app/home/rutas/rutas_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
                                          )),
                                );
                              },
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
            'Aves de San Martin',
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

class _BottomSheet extends StatelessWidget {
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
  }) : super(key: key);

  final String id;
  final String title;
  final String description;
  final bool tieneHospedaje;
  final bool tieneTurismo;
  final bool tieneAlimentacion;
  final VoidCallback avesEnlaZona;
  final VoidCallback fotosEnlaZona;
  final String imageUrl;

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
            Text(title,
                textAlign: TextAlign.left,
                style: const TextStyle(fontFamily: 'BreePeru', fontSize: 16)),
            const SizedBox(height: 4),
            Text(description,
                textAlign: TextAlign.left,
                style: const TextStyle(fontFamily: 'Poppins', fontSize: 13)),
            const SizedBox(height: 12),
            const Text(
              'Servicios que ofrecemos:',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                if (tieneHospedaje == true)
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
                if (tieneTurismo == true)
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.directions_bus_rounded,
                          color: Color(0xFF9B442B),
                        ),
                        Text('Guía turística',
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: 12))
                      ]),
                const SizedBox(
                  width: 8,
                ),
                if (tieneAlimentacion == true)
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
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Image(
                      image: NetworkImage(imageUrl),
                      height: 200,
                      width: 260,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton(
                  onPressed: avesEnlaZona,
                  child: const Text(
                    'Aves en la zona',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
                const SizedBox(width: 6),
                ElevatedButton(
                  onPressed: fotosEnlaZona,
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
}

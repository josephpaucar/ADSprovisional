import 'package:aves_de_san_martin/rutas/rutas_controller.dart';
import 'package:flutter/material.dart';
import 'package:aves_de_san_martin/models/app_data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RutasPage extends StatefulWidget {
  const RutasPage({super.key});

  @override
  State<RutasPage> createState() => _RutasPageState();
}

class _RutasPageState extends State<RutasPage> {
  final attractions = Attraction.attractoins;
  final _controller = RutasController();

  @override
  Widget build(BuildContext context) {
    final Marker llanteriaMarker = Marker(
        onTap: () {
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              context: context,
              builder: (builder) {
                return _BottomSheet(
                  id: attractions[0].id,
                  description: attractions[0].shortDescription,
                  title: attractions[0].name,
                  tieneHospedaje: attractions[0].tieneHospedaje,
                  tieneTurismo: attractions[0].tieneTurismo,
                  tieneAlimentacion: attractions[0].tieneAlimentacion,
                );
              });
        },
        markerId: MarkerId(attractions[0].name),
        infoWindow: InfoWindow(title: attractions[0].name),
        icon: BitmapDescriptor.defaultMarkerWithHue(13),
        position: LatLng(attractions[0].latitud, attractions[0].longitud));

    final Marker fanMarker = Marker(
        onTap: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (builder) {
                return _BottomSheet(
                  id: attractions[1].id,
                  description: attractions[1].shortDescription,
                  title: attractions[1].name,
                  tieneHospedaje: attractions[1].tieneHospedaje,
                  tieneTurismo: attractions[1].tieneTurismo,
                  tieneAlimentacion: attractions[1].tieneAlimentacion,
                );
              });
        },
        markerId: const MarkerId('fundoAltoNieva'),
        infoWindow: const InfoWindow(title: 'Fundo Alto Nieva'),
        icon: BitmapDescriptor.defaultMarkerWithHue(13),
        position: const LatLng(-5.6731361, -77.7681251));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Aves de San Martin',
          style: TextStyle(fontFamily: 'Pacifico'),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: _controller.initialCameraPosition,
        myLocationButtonEnabled: true,
        onMapCreated: _controller.onMapCreated,
        compassEnabled: false,
        markers: {fanMarker, llanteriaMarker},
        // onTap: _controller.onTap,
      ),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  final int id;
  final String title;
  final String description;
  final bool tieneHospedaje;
  final bool tieneTurismo;
  final bool tieneAlimentacion;

  const _BottomSheet({
    Key? key,
    required this.title,
    required this.description,
    required this.id,
    required this.tieneHospedaje,
    required this.tieneTurismo,
    required this.tieneAlimentacion,
  }) : super(key: key);

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
                style: const TextStyle(fontFamily: 'Pacifico', fontSize: 16)),
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
                        Text('Turismo',
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
              height: 170,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  Image(
                    image: AssetImage('assets/images/evento-ejemplo.jpg'),
                    height: 170,
                    width: 220,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Image(
                    image: AssetImage('assets/images/evento-ejemplo2.jpg'),
                    height: 170,
                    width: 220,
                    fit: BoxFit.cover,
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Aves en la zona',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
                const SizedBox(width: 6),
                ElevatedButton(
                  onPressed: () {},
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

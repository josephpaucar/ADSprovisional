import 'package:aves_de_san_martin/app/home/rutas/map_style.dart';
import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RutasController extends ChangeNotifier {
  final Map<MarkerId, Marker> _makers = {};

  Set<Marker> get markers => _makers.values.toSet();

  final initialCameraPosition = const CameraPosition(
    target: LatLng(-6.0039321, -77.2075635),
    zoom: 8,
  );

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(mapStyle);
  }

  /* void onTap(LatLng position) {
    final markerId = MarkerId(_makers.length.toString());
    final marker = Marker(
      markerId: markerId,
      position: position,
    );

    _makers[markerId] = marker;
    notifyListeners();
  }*/
}

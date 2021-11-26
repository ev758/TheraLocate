import 'package:thera_locate/therapy.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TherapyMarker {

  Marker therapyMarker(Therapy therapy) {
    var therapyMarkerId = therapy.name;

    return Marker(
        markerId: MarkerId(therapyMarkerId),
        draggable: false,
        infoWindow: InfoWindow(
            title: therapy.name, snippet: therapy.vicinity),
        position: LatLng(therapy.geometry.location.lat, therapy.geometry.location.lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(0xFF4DB6AC),
    );
  }

}
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:thera_locate/city.dart';
import 'package:thera_locate/city_autocomplete.dart';
import 'package:thera_locate/nearby_search_therapies.dart';
import 'package:thera_locate/therapy.dart';
import 'package:thera_locate/therapy_marker.dart';
import 'package:geocoding/geocoding.dart' as geocoder;

class CityTherapy with ChangeNotifier{
  var cityAutocomplete = CityAutocomplete();
  var nearbySearch = NearbySearchTherapies();
  List<City> cityLocations = [];
  StreamController<CityMap> cityLocationMap = StreamController<CityMap>.broadcast();
  Therapy? cityTherapy;
  var therapyMarker = TherapyMarker();
  List<Marker> cityTherapyMarkers = List<Marker>.empty();

  cityTextField(String cityText) async {
    cityLocations = await cityAutocomplete.cityAutocomplete(cityText);
    notifyListeners();
  }

  cityLocationMaps(String cityPlaceId) async {
    cityLocationMap.add(await cityAutocomplete.cityLocationTherapy(cityPlaceId));
    cityLocations = [];
    notifyListeners();
  }

  nearbySearchTherapies(String cityLocationAddress) async {
    print('city: ' + cityLocationAddress);
    var cityAddress = await geocoder.locationFromAddress(cityLocationAddress);
    var latitude;
    var longitude;
    latitude = cityAddress[0].latitude;
    longitude = cityAddress[0].longitude;
    print(latitude);
    print(longitude);
    var nearbySearchTherapies = await nearbySearch.nearbySearchTherapies(latitude, longitude);
    cityTherapyMarkers = [];

    if (0 < nearbySearchTherapies.length) {
      for (int i = 0; i < nearbySearchTherapies.length; i++) {
        var newTherapyMarker = therapyMarker.therapyMarker(nearbySearchTherapies[i]);
        print('new therapy marker');
        print(newTherapyMarker);
        cityTherapyMarkers.add(newTherapyMarker);
      }
    }

    notifyListeners();
}

  @override
  void dispose() {
    cityLocationMap.close();
    super.dispose();
  }
}
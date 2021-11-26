class Therapy {
  Geometry geometry;
  String name;
  String vicinity;

  Therapy({
    required this.geometry,
    required this.name,
    required this.vicinity,
  });

  factory Therapy.fromJson(Map<String, dynamic> json) {
    return Therapy(
      geometry: Geometry.fromJson(json['geometry']),
      name: json['name'],
      vicinity: json['vicinity'],
    );
  }
}

class CityMap {
  Geometry geometry;
  String formatted_address;
  String vicinity;

  CityMap({
    required this.geometry,
    required this.formatted_address,
    required this.vicinity,
  });

  factory CityMap.fromJson(Map<String, dynamic> json) {
    return CityMap(
      geometry: Geometry.fromJson(json['geometry']),
      formatted_address: json['formatted_address'],
      vicinity: json['vicinity'],
    );
  }
}

class Location {
  double lat;
  double lng;

  Location({
    required this.lat,
    required this.lng,
  });

  factory Location.fromJson(Map<dynamic, dynamic> json) {
    return Location(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}

class Geometry {
  Location location;

  Geometry({required this.location});

  factory Geometry.fromJson(Map<dynamic, dynamic> json) {
    return Geometry(
        location: Location.fromJson(json['location'])
    );
  }
}
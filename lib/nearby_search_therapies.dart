import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:thera_locate/therapy.dart';
import '.env.dart';

class NearbySearchTherapies {

  Future<List<Therapy>> nearbySearchTherapies(double latitude, double longitude) async {
    String nearbySearchURL = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=mentalhealth&location=$latitude%$longitude&radius=1500&type=therapy&key=$apiKey';
    print('nearbySearchURL: ' + nearbySearchURL);

    var responseToNearbySearch = await http.get(Uri.parse(nearbySearchURL));
    var parseNearbySearchURL = convert.jsonDecode(responseToNearbySearch.body);
    var nearbySearchResults = parseNearbySearchURL['results'] as List;
    if (responseToNearbySearch.statusCode == 200) {
      print('Status code: 200');
    }
    else {
      throw Exception('Failed to load map');
    }

    return nearbySearchResults.map((therapy) => Therapy.fromJson(therapy)).toList();
  }

}
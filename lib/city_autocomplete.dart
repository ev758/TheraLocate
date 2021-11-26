import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:thera_locate/city.dart';
import 'package:thera_locate/therapy.dart';
import '.env.dart';

class CityAutocomplete {

  Future<List<City>> cityAutocomplete(String cityText) async {
    var cityAutocompleteURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$cityText&types=(cities)&key=$apiKey';
    var cityAutocompleteResponse = await http.get(Uri.parse(cityAutocompleteURL));
    var parseCityAutocompleteURL = convert.jsonDecode(cityAutocompleteResponse.body);
    var cityAutocompleteResults = parseCityAutocompleteURL['predictions'] as List;
    return cityAutocompleteResults.map((city) => City.fromJson(city)).toList();
  }

  Future<CityMap> cityLocationTherapy(String cityPlaceId) async {
    var cityLocationURL = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$cityPlaceId&key=$apiKey';
    var cityLocationResponse = await http.get(Uri.parse(cityLocationURL));
    var parseCityLocationURL = convert.jsonDecode(cityLocationResponse.body);
    var cityLocationResults = parseCityLocationURL['result'] as Map<String, dynamic>;
    return CityMap.fromJson(cityLocationResults);
  }
}
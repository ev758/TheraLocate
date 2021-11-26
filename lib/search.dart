import 'package:flutter/material.dart';
import 'package:thera_locate/city_therapy.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:thera_locate/therapy.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  Search({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MySearchState createState() => _MySearchState();
}

class _MySearchState extends State<Search> {

  Completer<GoogleMapController> cityMapController = Completer();
  var cityController = TextEditingController();
  late StreamSubscription cityMapLocationSub;

  void cityMapLocation(Completer<GoogleMapController> cityMapControllerPar) {
    cityMapController = cityMapControllerPar;
  }

  Future<void> cityLocation(CityMap city) async {
    GoogleMapController newCityMapController = await cityMapController.future;
    newCityMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(city.geometry.location.lat, city.geometry.location.lng),
          zoom: 14.0,
        )
      )
    );
  }

  @override
  void initState() {
    var cityTherapy = Provider.of<CityTherapy>(context, listen: false);
    cityMapLocationSub = cityTherapy.cityLocationMap.stream.listen((city) {
      if (city != null) {
        cityLocation(city);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    cityController.dispose();
    cityMapLocationSub.cancel();
    var cityTherapy = Provider.of<CityTherapy>(context, listen: false);
    cityTherapy.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var cityTherapy = Provider.of<CityTherapy>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFD7ECE2),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 10,
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Text(
                      'Search',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Arial',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                Expanded(
                  flex: 10,
                  child: Container(
                    margin: EdgeInsets.only(right: 20, left: 20),
                    child: TextField(
                      controller: cityController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter a City',
                        prefixIcon: Icon(Icons.search),
                      ),
                      onChanged: (value) => cityTherapy.cityTextField(value),
                    ),
                  ),
                ),

                Expanded(
                  flex: 60,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: MediaQuery.of(context).size.height - 400.0,
                        child: GoogleMap(
                          markers: Set<Marker>.of(cityTherapy.cityTherapyMarkers),
                          onMapCreated: (GoogleMapController cityMapControllerThera) {
                            cityMapController.complete(cityMapControllerThera);
                          },
                          initialCameraPosition: CameraPosition(
                              target: LatLng(41.8781, -87.6298), zoom: 14.0),
                        ),
                      ),

                      if (cityTherapy.cityLocations != null && cityTherapy.cityLocations.length != 0) Container(
                        height: MediaQuery.of(context).size.height - 400.0,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.5),
                            backgroundBlendMode: BlendMode.darken
                        ),
                      ),

                      if (cityTherapy.cityLocations != null && cityTherapy.cityLocations.length != 0) Container(
                        height: MediaQuery.of(context).size.height - 400.0,
                        child: ListView.builder(
                            itemCount: cityTherapy.cityLocations.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(cityTherapy.cityLocations[index].description,
                                    style: TextStyle(color: Colors.white)
                                ),
                                onTap: () {
                                  cityTherapy.cityLocationMaps(
                                    cityTherapy.cityLocations[index].place_id
                                  );
                                  cityTherapy.nearbySearchTherapies(cityTherapy.cityLocations[index].description);
                                }
                              );
                            }
                        ),
                      ),

                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:ohana_care/model/location.dart';
import 'package:ohana_care/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class MapMultiMarker extends StatefulWidget {
  const MapMultiMarker({Key? key}) : super(key: key);

  @override
  State<MapMultiMarker> createState() => _MapMultiMarkerState();
}

class _MapMultiMarkerState extends State<MapMultiMarker> {
  List<Location> clityList = [];

  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _markers.clear();
    setState(() {
      // put marker
      for (int i = 0; i < clityList.length; i++) {
        final marker = Marker(
          markerId: MarkerId(clityList[i].name),
          position: LatLng(clityList[i].lat, clityList[i].lng),
          infoWindow: InfoWindow(
            title: clityList[i].name,
            snippet: clityList[i].address,
          ),
        );
        _markers[clityList[i].name] = marker;
      }
    });
  }

  launchMap(lat, long) {
    MapsLauncher.launchCoordinates(lat, long);
  }

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var url = Uri.parse('https://sticheapi.vercel.app/api/location');
      var response = await http.get(url,
        headers: {
          "Authorization": "Bearer ${authProvider.getUserData.id}"
        });
      var jsonResponse = jsonDecode(response.body);

      // cityListData fetch
      List<Location> cityListData = [];
      for (var location in jsonResponse['data']) {
        String latLng = location['coordinates'];
        List<String> coordinates = latLng.split(',');
        Location city = Location(
          address: location['address'], 
          category: location['category'], 
          lat: double.parse(coordinates[0]), 
          lng: double.parse(coordinates[1]), 
          name: location['name']
        );
        cityListData.add(city);
      }

      setState(() {
        clityList = cityListData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (clityList.isNotEmpty) GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition:  CameraPosition(
              target: LatLng(clityList[0].lat, clityList[0].lng),
              zoom: 13,
            ),
            markers: _markers.values.toSet(),
          ),
          if (clityList.isNotEmpty) Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      setState(() {
                        _markers.clear();
                        for (int i = 0; i < clityList.length; i++) {
                          if (clityList[i].category == "Hospital") {
                            final marker = Marker(
                              markerId: MarkerId(clityList[i].name),
                              position: LatLng(
                                clityList[i].lat,
                                clityList[i].lng,
                              ),
                              infoWindow: InfoWindow(
                                title: clityList[i].name,
                                snippet: clityList[i].address,
                                onTap: () {
                                  print(
                                    "${clityList[i].lat}, ${clityList[i].lng}",
                                  );
                                },
                              ),
                              onTap: () {
                                print("Clicked on marker");
                              },
                            );
                            _markers[clityList[i].name] = marker;
                          }
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 217, 217, 217),
                      ),
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(left: 20, top: 40),
                      height: 40.0,
                      alignment: Alignment.center,
                      child: const Text('Hospital'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _markers.clear();
                        for (int i = 0; i < clityList.length; i++) {
                          if (clityList[i].category == "Confinement Center") {
                            final marker = Marker(
                              markerId: MarkerId(clityList[i].name),
                              position: LatLng(
                                clityList[i].lat,
                                clityList[i].lng,
                              ),
                              infoWindow: InfoWindow(
                                title: clityList[i].name,
                                snippet: clityList[i].address,
                                onTap: () {
                                  print(
                                    "${clityList[i].lat}, ${clityList[i].lng}",
                                  );
                                },
                              ),
                              onTap: () {
                                print("Clicked on marker");
                              },
                            );
                            _markers[clityList[i].name] = marker;
                          }
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 217, 217, 217),
                      ),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 20, top: 40),
                      height: 40.0,
                      alignment: Alignment.center,
                      child: const Text('Confinement Center'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _markers.clear();
                        for (int i = 0; i < clityList.length; i++) {
                          if (clityList[i].category == "NGOs") {
                            final marker = Marker(
                              markerId: MarkerId(clityList[i].name),
                              position: LatLng(
                                clityList[i].lat,
                                clityList[i].lng,
                              ),
                              infoWindow: InfoWindow(
                                title: clityList[i].name,
                                snippet: clityList[i].address,
                                onTap: () {
                                  print(
                                    "${clityList[i].lat}, ${clityList[i].lng}",
                                  );
                                },
                              ),
                              onTap: () {
                                print("Clicked on marker");
                              },
                            );
                            _markers[clityList[i].name] = marker;
                          }
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 217, 217, 217),
                      ),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 20, top: 40),
                      height: 40.0,
                      alignment: Alignment.center,
                      child: const Text('NGOs'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _markers.clear();
                        for (int i = 0; i < clityList.length; i++) {
                          if (clityList[i].category == "Clinic") {
                            final marker = Marker(
                              markerId: MarkerId(clityList[i].name),
                              position: LatLng(
                                clityList[i].lat,
                                clityList[i].lng,
                              ),
                              infoWindow: InfoWindow(
                                title: clityList[i].name,
                                snippet: clityList[i].address,
                                onTap: () {
                                  print(
                                    "${clityList[i].lat}, ${clityList[i].lng}",
                                  );
                                },
                              ),
                              onTap: () {
                                print("Clicked on marker");
                              },
                            );
                            _markers[clityList[i].name] = marker;
                          }
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 217, 217, 217),
                      ),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 20, top: 40),
                      height: 40.0,
                      alignment: Alignment.center,
                      child: const Text('Clinics'),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _markers.clear();
                        for (int i = 0; i < clityList.length; i++) {
                          if (clityList[i].category == "Pharmacy") {
                            final marker = Marker(
                              markerId: MarkerId(clityList[i].name),
                              position: LatLng(
                                clityList[i].lat,
                                clityList[i].lng,
                              ),
                              infoWindow: InfoWindow(
                                title: clityList[i].name,
                                snippet: clityList[i].address,
                                onTap: () {
                                  print(
                                    "${clityList[i].lat}, ${clityList[i].lng}",
                                  );
                                },
                              ),
                              onTap: () {
                                print("Clicked on marker");
                              },
                            );
                            _markers[clityList[i].name] = marker;
                          }
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromARGB(255, 217, 217, 217),
                      ),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 20, top: 40),
                      height: 40.0,
                      alignment: Alignment.center,
                      child: const Text('Pharmacy'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

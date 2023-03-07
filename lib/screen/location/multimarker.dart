import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';

class MapMultiMarker extends StatefulWidget {
  const MapMultiMarker({Key? key}) : super(key: key);

  @override
  State<MapMultiMarker> createState() => _MapMultiMarkerState();
}

class _MapMultiMarkerState extends State<MapMultiMarker> {
  final List<Map<String, dynamic>> clityList = const [
    {
      "address":
          "Jalan Pahang, 50586 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur",
      "id": "hospital",
      "lat": 3.171507541654249,
      "lng": 101.70277416938735,
      "name": "Kuala Lumpur Hospital",
    },
    {
      "address":
          "282, 286 & 288 Block A, B and Medical Office Block, Jalan Ampang, 50450 Kuala Lumpur",
      "id": "hospital",
      "lat": 3.160058041615352,
      "lng": 101.74112312272193,
      "name": "Gleneagles Hospital Kuala Lumpur",
    },
    {
      "address":
          "8, Jalan Bukit Pantai, Bangsar, 59100 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur",
      "id": "hospital",
      "lat": 3.1213924349358577,
      "lng": 101.66804062260965,
      "name": "Pantai Hospital Kuala Lumpur",
    },
    {
      "address":
          "102, Jln Pudu, Bukit Bintang, 55100 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur",
      "id": "hospital",
      "lat": 3.1466447563202493,
      "lng": 101.70469567717814,
      "name": "Tung Shin Hospital",
    },
    {
      "address":
          "Damai Kompleks, 36, Jalan Chemur, Titiwangsa Sentral, 50400 Kuala Lumpur, Federal Territory of Kuala Lumpur",
      "id": "hospital",
      "lat": 3.170836336969684,
      "lng": 101.69938416825384,
      "name": "KPJ Sentosa KL Specialist Hospital",
    },
    {
      "address":
          "Lot 1.23, Level 1, Pavilion KL Shopping Mall, 168, Jln Bukit Bintang, 55100 Kuala Lumpur",
      "id": "pharmacy",
      "lat": 3.149983771539391,
      "lng": 101.71380890892739,
      "name": "CARiNG Pharmacy Pavilion, Kuala Lumpur",
    },
    {
      "address":
          "Lot 1.69B, Ground Floor, Wisma Central, Jalan Ampang, Kuala Lumpur, 50250 Wilayah Persekutuan, Federal Territory of Kuala Lumpur",
      "id": "pharmacy",
      "lat": 3.1586169440229206,
      "lng": 101.71550719996402,
      "name": "Health Lane Family Pharmacy Wisma Central",
    },
    {
      "address":
          "Plaza Pudu, Ub3, Jalan Landak, Pudu, 55100 Kuala Lumpur, Federal Territory of Kuala Lumpur",
      "id": "pharmacy",
      "lat": 3.1384874885682157,
      "lng": 101.71294058614481,
      "name": "Mediland Pharmacy",
    },
    {
      "address":
          "21, Jalan Tun Sambanthan 4, Brickfields, 50470 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur",
      "id": "pharmacy",
      "lat": 3.1325604590906306,
      "lng": 101.68849876338034,
      "name": "Carelink Pharmacy",
    },
    {
      "address":
          "Ground Floor, Wisma Paradise, 63, Jalan Ampang, 50450 Kuala Lumpur",
      "id": "pharmacy",
      "lat": 3.151861451587354,
      "lng": 101.69850945444043,
      "name": "Paradise Pharmacy",
    },
    {
      "address": "81-B, Jalan SS 15/5a, Ss 15, 47500 Subang Jaya, Selangor",
      "id": "ngos",
      "lat": 3.081732984258335,
      "lng": 101.59278788791686,
      "name":
          "Federation of Reproductive Health Associations, Malaysia (FRHAM) ",
    },
    {
      "address":
          "Unit 305, Block A, Phileo Damansara I, Jalan 16/11, Off, Jalan Damansara, Seksyen 16, 46350 Petaling Jaya, Selangor",
      "id": "ngos",
      "lat": 3.1279791419245373,
      "lng": 101.64284683209348,
      "name": "Family Planning Association of Malaysia (FPAM)",
    },
    {
      "address":
          "246, Lorong Enau, Kampung Datuk Keramat, 55000 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur",
      "id": "ngos",
      "lat": 3.16144792278516,
      "lng": 101.73317479289585,
      "name": "International Planned Parenthood Federation (IPPF)",
    },
    {
      "address":
          "1 Jalan Perdana 10/10, Pandan Perdana Cheras, 1, Jalan Perdana 10/10, Pandan Perdana, 56100 Ampang Jaya, Selangor",
      "id": "ngos",
      "lat": 3.1197378246166236,
      "lng": 101.74477408610032,
      "name": "NEJLIKA Mother & Baby Centre",
    },
    {
      "address":
          "16, Lorong Tiong Nam 5, Chow Kit, 50350 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur",
      "id": "ngos",
      "lat": 3.164015343441656,
      "lng": 101.69413508622242,
      "name": "Yayasan Chow Kit",
    },
    {
      "address":
          "Plaza Vads, Level 2, Podium, 1, Jalan Tun Mohd Fuad, Taman Tun Dr Ismail, 60000 Kuala Lumpur",
      "id": "ngos",
      "lat": 3.142383510793485,
      "lng": 101.62889544064763,
      "name": "LYC Mother & Child Centre",
    },
    {
      "address":
          "2, Jalan Awan Cina, Taman Yarl, 58200 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur",
      "id": "ngos",
      "lat": 3.0660767037443812,
      "lng": 101.6667376949475,
      "name": "Felicity Postpartum Care Sdn Bhd",
    },
    {
      "address":
          "23, Jln Setia Dagang AJ U13/AJ, Setia Alam, 40170 Shah Alam, Selangor",
      "id": "confinement",
      "lat": 3.106153583011654,
      "lng": 101.4702307225776,
      "name": "Amazing Confinement Care Sdn. Bhd.",
    },
    {
      "name": "Zinnia Fields Postnatal Retreat",
      "id": "confinement",
      "lat": 3.110877287947477,
      "lng": 101.67618266332602,
      "address":
          "15, Lorong Chekor, Jln Klang Lama, Taman Halimahton, 58000 Kuala Lumpur, Federal Territory of Kuala Lumpur",
    },
    {
      "address":
          "A-LG-08 Central Residence, 366 Jalan, Sungai Besi Expy, 57100 Kuala Lumpur",
      "id": "confinement",
      "lat": 3.083421065836276,
      "lng": 101.69770221774047,
      "name": "Luna Confinement Centre",
    },
    {
      "address":
          "Level 6, 7 & 8, No. 30A, Menara Ruyi, Lorong Kapar, Jalan 2/87G, Off, Jln Syed Putra, 58000 Kuala Lumpur",
      "id": "confinement",
      "lat": 3.1226710913993823,
      "lng": 101.68334816812002,
      "name": "Kimporo Postnatal Rejuvenation",
    },
    {
      "address":
          "Taman Metropolitan, 23a, Persiaran Perdana, Kepong, 52100 Kuala Lumpur, Selangor",
      "id": "confinement",
      "lat": 3.2193260854283476,
      "lng": 101.64107923188025,
      "name": "Joie Confinement Center",
    },
    {
      "address":
          "Jalan Pinang, Kuala Lumpur, 50450 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur",
      "id": "clinics",
      "lat": 3.154618241166282,
      "lng": 101.70947218619463,
      "name": "Queens Medical Clinic",
    },
    {
      "address":
          "Unit 5-1, Pillar 8, Menara Pacific 3A, Kampung Haji Abdullah Hukum, 59200 Kuala Lumpur",
      "id": "clinics",
      "lat": 3.1193994667154588,
      "lng": 101.67511759985686,
      "name": "DTAP Clinic",
    },
    {
      "address":
          "Lot 1.02, Ground Floor, Wisma Central, Jalan Ampang, Kuala Lumpur, 50450 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur",
      "id": "clinics",
      "lat": 3.1599881478327774,
      "lng": 101.71447723170783,
      "name": "Poliklinik Kumpulan City, Wisma Central",
    },
    {
      "address":
          "Rohas Perkasa, Mezzanine Floor East Wing, No. 9, Jalan P. Ramlee, Wilayah, 50250 Kuala Lumpur",
      "id": "clinics",
      "lat": 3.154988048750077,
      "lng": 101.70736594068875,
      "name": "The KL Clinic (Rohas Perkasa)",
    },
    {
      "address":
          "P-G-022, Centrestage, Jalan 13/1, Seksyen 13, 46200 Petaling Jaya, Selangor",
      "id": "clinics",
      "lat": 3.1119390877731243,
      "lng": 101.64014199983565,
      "name": "Klinik Dr. Inder",
    },
  ];

  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _markers.clear();
    setState(() {
      for (int i = 0; i < clityList.length; i++) {
        final marker = Marker(
          markerId: MarkerId(clityList[i]['name']),
          position: LatLng(clityList[i]['lat'], clityList[i]['lng']),
          infoWindow: InfoWindow(
            title: clityList[i]['name'],
            snippet: clityList[i]['address'],
          ),
        );
        _markers[clityList[i]['name']] = marker;
      }
    });
  }

  launchMap(lat, long) {
    MapsLauncher.launchCoordinates(lat, long);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(clityList[0]['lat'], clityList[0]['lng']),
              zoom: 13,
            ),
            markers: _markers.values.toSet(),
          ),
          Container(
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
                          if (clityList[i]['id'] == "hospital") {
                            final marker = Marker(
                              markerId: MarkerId(clityList[i]['name']),
                              position: LatLng(
                                clityList[i]['lat'],
                                clityList[i]['lng'],
                              ),
                              infoWindow: InfoWindow(
                                title: clityList[i]['name'],
                                snippet: clityList[i]['address'],
                                onTap: () {
                                  print(
                                    "${clityList[i]['lat']}, ${clityList[i]['lng']}",
                                  );
                                },
                              ),
                              onTap: () {
                                print("Clicked on marker");
                              },
                            );
                            _markers[clityList[i]['name']] = marker;
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
                          if (clityList[i]['id'] == "confinement") {
                            final marker = Marker(
                              markerId: MarkerId(clityList[i]['name']),
                              position: LatLng(
                                clityList[i]['lat'],
                                clityList[i]['lng'],
                              ),
                              infoWindow: InfoWindow(
                                title: clityList[i]['name'],
                                snippet: clityList[i]['address'],
                                onTap: () {
                                  print(
                                    "${clityList[i]['lat']}, ${clityList[i]['lng']}",
                                  );
                                },
                              ),
                              onTap: () {
                                print("Clicked on marker");
                              },
                            );
                            _markers[clityList[i]['name']] = marker;
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
                          if (clityList[i]['id'] == "ngos") {
                            final marker = Marker(
                              markerId: MarkerId(clityList[i]['name']),
                              position: LatLng(
                                clityList[i]['lat'],
                                clityList[i]['lng'],
                              ),
                              infoWindow: InfoWindow(
                                title: clityList[i]['name'],
                                snippet: clityList[i]['address'],
                                onTap: () {
                                  print(
                                    "${clityList[i]['lat']}, ${clityList[i]['lng']}",
                                  );
                                },
                              ),
                              onTap: () {
                                print("Clicked on marker");
                              },
                            );
                            _markers[clityList[i]['name']] = marker;
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
                          if (clityList[i]['id'] == "clinics") {
                            final marker = Marker(
                              markerId: MarkerId(clityList[i]['name']),
                              position: LatLng(
                                clityList[i]['lat'],
                                clityList[i]['lng'],
                              ),
                              infoWindow: InfoWindow(
                                title: clityList[i]['name'],
                                snippet: clityList[i]['address'],
                                onTap: () {
                                  print(
                                    "${clityList[i]['lat']}, ${clityList[i]['lng']}",
                                  );
                                },
                              ),
                              onTap: () {
                                print("Clicked on marker");
                              },
                            );
                            _markers[clityList[i]['name']] = marker;
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
                          if (clityList[i]['id'] == "pharmacy") {
                            final marker = Marker(
                              markerId: MarkerId(clityList[i]['name']),
                              position: LatLng(
                                clityList[i]['lat'],
                                clityList[i]['lng'],
                              ),
                              infoWindow: InfoWindow(
                                title: clityList[i]['name'],
                                snippet: clityList[i]['address'],
                                onTap: () {
                                  print(
                                    "${clityList[i]['lat']}, ${clityList[i]['lng']}",
                                  );
                                },
                              ),
                              onTap: () {
                                print("Clicked on marker");
                              },
                            );
                            _markers[clityList[i]['name']] = marker;
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

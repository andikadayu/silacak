import 'package:flutter/material.dart';
import 'package:silacak/nav-drawer-admin.dart';
import 'package:silacak/location_services.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart' as latLng;
import 'package:mapbox_gl/mapbox_gl.dart';

class AdminPage extends StatefulWidget {
  AdminPage({required this.username});
  final String username;
  @override
  _AdminPage createState() => _AdminPage();
}

class _AdminPage extends State<AdminPage> {
  @override
  void initState() {
    super.initState();
    LocationServices().getCoordinate();
  }

  late MapboxMapController mapController;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin"),
      ),
      drawer: DrawerWidget(),
      body: ListView(
        children: [
          FutureBuilder(
            future: LocationServices().getCoordinate(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.toString());
              } else {
                return Text("Loading Alamat");
              }
            },
          ),
          FutureBuilder<List<double>>(
            future: Future.wait(
                [LocationServices().getLat(), LocationServices().getLong()]),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  margin: EdgeInsets.all(5),
                  child: SizedBox(
                    height: 300,
                    width: 200,
                    child: MapboxMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        zoom: 17,
                        target: LatLng(7.7823, 112.123),
                      ),
                    ),
                  ),
                );
              } else {
                return Text("Loading....");
              }
            },
          ),
        ],
      ),
      // body: FlutterMap (
      //     options: MapOptions(
      //         center: latLng.LatLng(-7.938053860018475, 112.62193226848204),
      //         zoom: 13.0,
      //   ),
      //   layers: [
      //     TileLayerOptions(
      //       urlTemplate: "https://api.mapbox.com/styles/v1/mohamadarif/cku6bql0d3f4618o73eqn6kd1/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibW9oYW1hZGFyaWYiLCJhIjoiY2sxaXdndnJiMG1jYjNob2Nrc3RlenMxaiJ9.9kzVbPnv15BqCLV8NUWK9Q",
      //       additionalOptions: {
      //         'accessToken': 'pk.eyJ1IjoibW9oYW1hZGFyaWYiLCJhIjoiY2sxaXdndnJiMG1jYjNob2Nrc3RlenMxaiJ9.9kzVbPnv15BqCLV8NUWK9Q',
      //         'id': 'mapbox.mapbox-streets-v8',
      //       },
      //     ),
      //     MarkerLayerOptions(
      //       markers: [
      //         Marker(
      //           width: 80.0,
      //           height: 80.0,
      //           point: latLng.LatLng(-7.938053860018475, 112.62193226848204),
      //           builder: (ctx) =>
      //           Container(
      //             child: Icon(Icons.location_pin),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.location_searching),
      //   onPressed: () {
      //      _getCurrentLocation();
      // }),
    );
  }
}

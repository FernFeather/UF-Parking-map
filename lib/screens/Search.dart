import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(29.6516, -82.3248), zoom: 8.0)))
      ],
    ));
  }
}

/*class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        zoomControlsEnabled: true,
        initialCameraPosition:
            CameraPosition(target: LatLng(29.6516, 82.3248), zoom: 8.0),
      ),
    );
  }
}*/

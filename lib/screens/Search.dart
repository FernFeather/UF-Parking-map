import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position?>(context);

    return Scaffold(
        body: (currentPosition != null)
            ? Column(
                children: <Widget>[
                  Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width,
                      child: GoogleMap(
                          zoomGesturesEnabled: true,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(currentPosition.latitude,
                                  currentPosition.longitude),
                              //target: LatLng(29.6328784, -82.34901329340119),
                              zoom: 16.0)))
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
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

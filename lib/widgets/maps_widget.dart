/*
    Desc:
      Class containing all the map-based functions necessary for the 
        app.

    To-do:
      - Fix map positioning
      - Fix map loading screen and initial position
      - If user accepts location service, zoom in on their position
      - Remove Google's parking markers
 */
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../services/parking_data.dart';

class MapsWidget extends StatefulWidget {
  const MapsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MapsWidget> createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  final LatLng coordinatesUF =
      const LatLng(29.643668902938217, -82.35492419939918);
  final Set<Marker> markers = new Set();

  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position?>(context);
    GoogleMapController? mapController;
    /*
      ============== GOOGLE MAPS PANEL ============
    */
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        zoomGesturesEnabled: true,
        myLocationEnabled: (currentPosition != null) ? true : false,
        myLocationButtonEnabled: false,
        padding: (mapController == null)
            ? EdgeInsets.zero
            : EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * (1 / 12),
              ),
        initialCameraPosition: CameraPosition(
            target: (currentPosition != null)
                // Target user's current position
                ? LatLng(currentPosition.latitude, currentPosition.longitude)
                // Target University of Florida
                : coordinatesUF,
            zoom: 16.0),
        onMapCreated: (GoogleMapController controller) {
          setState(() {});
        },
        markers: getMarkers(),
      ),
    );
  }

  Set<Marker> getMarkers() {
    setState(() {
      ParkingDatabaseService.parkingList.forEach((var e) {
        markers.add(Marker(
          markerId: MarkerId(e.toString()),
          position: e.coordPair,
          infoWindow: InfoWindow(
            title: e.name,
            snippet: e.approxCap,
          ),
          icon: BitmapDescriptor.defaultMarker,
        ));
      });
    });
    return markers;
  }
}

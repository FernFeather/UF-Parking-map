/*
    Desc:
      Class containing all the map-based functions necessary for the 
        app.

    To-do:
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
    required this.giveControllerToParent,
  }) : super(key: key);

  final Function(GoogleMapController controller) giveControllerToParent;

  @override
  State<MapsWidget> createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  final LatLng coordinatesUF =
      const LatLng(29.643668902938217, -82.35492419939918);
  final Set<Marker> markers = {};
  double bottomOffset = 0;
  GoogleMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position?>(context);
    /*
      ============== GOOGLE MAPS PANEL ============
    */
    return Stack(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GoogleMap(
            zoomGesturesEnabled: true,
            myLocationEnabled: (currentPosition != null) ? true : false,
            myLocationButtonEnabled: false,
            padding: EdgeInsets.only(
              bottom: bottomOffset,
            ),
            initialCameraPosition:
                CameraPosition(target: coordinatesUF, zoom: 16.0),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
              widget.giveControllerToParent(controller);
              setState(() {
                bottomOffset = MediaQuery.of(context).size.height * (1 / 11);
              });
            },
            markers: getMarkers(),
          ),
        ),
        Positioned(
            top: MediaQuery.of(context).size.height * (8 / 11) - 12,
            left: MediaQuery.of(context).size.width - 64,
            child: (currentPosition != null)
                ? FloatingActionButton(
                    onPressed: () {
                      _mapController!.moveCamera(
                          CameraUpdate.newCameraPosition(CameraPosition(
                        target: LatLng(
                          currentPosition.latitude,
                          currentPosition.longitude,
                        ),
                        zoom: 16,
                      )));
                    },
                    backgroundColor: Colors.white.withOpacity(0.8),
                    child: const Icon(
                      Icons.gps_fixed,
                      color: Colors.black54,
                    ),
                  )
                : const SizedBox.shrink()),
      ],
    );
  }

  Set<Marker> getMarkers() {
    setState(() {
      for (var e in ParkingDatabaseService.parkingList) {
        markers.add(Marker(
          markerId: MarkerId(e.toString()),
          position: e.coordPair,
          infoWindow: InfoWindow(
            title: e.name,
            snippet: e.approxCap,
          ),
          icon: BitmapDescriptor.defaultMarker,
        ));
      }
    });
    return markers;
  }
}

// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Search extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Column(children: <Widget> [
        // ignore: sized_box_for_whitespace
        Container(
          height: MediaQuery.of(context).size.height/3,
          width: MediaQuery.of(context).size.height,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(target: LatLng(29.6436, 82.3549)),
            zoomGesturesEnabled: true,
          )
        )
      ],),
    );
  }
}
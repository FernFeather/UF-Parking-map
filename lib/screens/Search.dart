import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position?>(context);

    return Scaffold(
      body: (currentPosition != null)
        ? Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                /*
                ============== GOOGLE MAPS PANEL ============
                 */
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    zoomGesturesEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(currentPosition.latitude,
                                    currentPosition.longitude),
                      //target: LatLng(29.6328784, -82.34901329340119),
                                zoom: 16.0),
                  ),
                ),
              ],
            ),
          /*
          ============= SLIDE UP PANEL ==============
           */
            SlidingUpPanel(
              maxHeight: MediaQuery.of(context).size.height * (2/3),
              panel: Center(
                child: Text("This is the sliding Widget"),
              ),
              collapsed: Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlue[100],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                ),
                child: Center(
                  child: Text(
                      "Placeholder for search Bar"
                  ),
                ),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
            ),
          ],
        )
        : Center(
            child: CircularProgressIndicator(),
          ),
    );
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

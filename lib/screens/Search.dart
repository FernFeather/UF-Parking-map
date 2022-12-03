import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../services/parking_data.dart';

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
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * (1/12)
                    ),
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
              backdropEnabled: true,
              backdropOpacity: 0.0,
              maxHeight: MediaQuery.of(context).size.height * (9/10),
              minHeight: MediaQuery.of(context).size.height * (1/12),
              header: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * (1/12),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[200],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                          "Placeholder for search Bar"
                      ),
                    ),
                  ),
                ],
              ),
              panelBuilder: (ScrollController sc) => _scrollingList(sc, context),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
            ),
          ],
        )
        : const Center(
            child: CircularProgressIndicator(),
          ),
    );
  }

  Widget _scrollingList(ScrollController sc, BuildContext context) {
    return ListView.builder (
      controller: sc,
      itemCount: ParkingDatabaseService.parkingList.length,
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * (1/12),
          bottom: 12.0,
          left: 12.0,
          right: 12.0,
      ),
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
          child: Card(
            child: ListTile(
              title: Text(ParkingDatabaseService.parkingList[i].name!),
              trailing: const Icon(
                Icons.keyboard_arrow_right_rounded,
                color: Colors.lightBlue,
              ),
            ),
          ),
        );
      },
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

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parkings_/provider/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:parkings_/services/parking_data.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position?>(context);

    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              child: Text('Logout'),
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
            )
          ],
        ),
        body: (currentPosition != null)
            ? Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      zoomGesturesEnabled: true,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(29.6328784, -82.34901329340119),
                          //target: LatLng(currentPosition.latitude, currentPosition.longitude ),
                          zoom: 16.0),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: ParkingDatabaseService.parkingList.length,
                    itemBuilder: ((context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                              ParkingDatabaseService.parkingList[index].name!),
                        ),
                      );
                    }),
                  ))
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

import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/*
  Desc:
    A class that manages database functions and retrieves parking data from
    the UF Parking Map Firebase database and stores that data into an ordered
    list of parking location objects that can be accessed.

  Notes:
    What happens when database gets updated when app is running?
      Updates to parking list needs to trigger a list "refresh" in panel_widget
 */
class ParkingDatabaseService {
  // Parking location objects stored in this list
  static List<ParkingLocation> parkingList = [];
  // Accessing the database?
  static FirebaseDatabase database = FirebaseDatabase.instance;
  static DatabaseReference dbRef = database.ref("locations/");
  // Not the best implementation to wait for parking data, but it will do
  static Future<void> awaitParkingData() async {
    while (await dbRef.onValue.isEmpty) {}
  }

  // Creates event listener to listen and react to database changes
  static startEventListener() {
    dbRef.onValue.listen((DatabaseEvent event) {
      if (!event.snapshot.exists) {
        // print('No data available');
      } else {
        // Initialize and update parking data
        parkingList.clear();
        // Iterate through every location subitem in Firebase database
        for (final location in event.snapshot.children) {
          double lat = (location.child("coords/0").value as double);
          double lng = (location.child("coords/1").value as double);
          LatLng coord = LatLng(lat, lng);

          List<String> locationDecals = [];
          for (int i = 0; i < location.child("decals").children.length; i++) {
            locationDecals.add(location.child("decals/$i").value as String);
          }
          List<String> locationNotes = [];
          for (int i = 0; i < location.child("notes").children.length; i++) {
            locationNotes.add(location.child("notes/$i").value as String);
          }
          // Add new ParkingLocation object for each subitem and
          // construct each ParkingLocation object according to its values
          parkingList.add(ParkingLocation(
              name: location.child("name").value as String,
              coordPair: coord,
              decals: locationDecals,
              approxCap: location.child("approxCap").value as String,
              restrictStart: location.child("restrictStart").value as String,
              restrictEnd: location.child("restrictEnd").value as String,
              hasDisabled: location.child("disabled").value as bool,
              hasEV: location.child("ev").value as bool,
              hasMotorScooter: location.child("motorScooter").value as bool,
              hasPaid: location.child("paid").value as bool,
              notes: locationNotes));
        }
        // Sort list alphabetically by name
        parkingList.sort();
      }
    });
  }
}

/*
    Desc:
      A class that stores pertinent information for a particular parking location
 */
class ParkingLocation extends Comparable {
  // Parking information
  final String? name;
  final LatLng coordPair;
  final List<String>? decals;
  final String? approxCap;
  final String? restrictStart;
  final String? restrictEnd;
  final bool? hasDisabled;
  final bool? hasEV;
  final bool? hasMotorScooter;
  final bool? hasPaid;
  final List<String>? notes;

  ParkingLocation(
      {required this.name,
      required this.coordPair,
      required this.decals,
      required this.approxCap,
      required this.restrictStart,
      required this.restrictEnd,
      required this.hasDisabled,
      required this.hasEV,
      required this.hasMotorScooter,
      required this.hasPaid,
      required this.notes});

  @override
  String toString() {
    if (name == null) {
      return "null";
    } else {
      return name!;
    }
  }

  @override
  int compareTo(other) {
    if (name == null && other.name == null) {
      return 0;
    } else if (name == null) {
      return (1.0 / 0.0) as int;
    } else if (other.name == null) {
      return (-1.0 / 0.0) as int;
    } else {
      return name!.compareTo(other.name!);
    }
  }
}

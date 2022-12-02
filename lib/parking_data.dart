import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

/*
  Desc:
    A class that manages database functions and retrieves parking data from
    the UF Parking Map Firebase database and stores that data into an ordered
    list of parking location objects that can be accessed.

  Notes:
    What happens when database gets updated when app is running?
 */
class ParkingDatabaseService {
  // Parking location objects stored in this list
  static List<ParkingLocation> parkingList = [];
  // Accessing the database?
  static FirebaseDatabase database = FirebaseDatabase.instance;
  static DatabaseReference dbRef = database.ref("locations/");
  // Creates event listener to listen and react to database changes
  static startEventListener() {
    dbRef.onValue.listen((DatabaseEvent event) {
      if (!event.snapshot.exists) {
        print('No data available');
      }
      else {
        // Initialize and update parking data
        print(event.snapshot.value);
        // Iterate through every location subitem in Firebase database
        for (final location in event.snapshot.children) {
          print(location.value);
          // Create new _ParkingLocation object for each subitem and
          /*ParkingLocation(
            name:
            coords:
            decals:

          )*/
          // construct each _ParkingLocation object according to its values

        }
        // Sort list
      }
    });
  }
}

class ParkingLocation {
  // Parking information
  final String? name;
  final List<double>? coords;
  final List<String>? decals;
  final String? approxCap;
  final String? restrictStart;
  final String? restrictEnd;
  final bool? disabled;
  final bool? ev;
  final bool? motorScooter;
  final bool? paid;
  final List<String>? notes;

  ParkingLocation({
    this.name,
    this.coords,
    this.decals,
    this.approxCap,
    this.restrictStart,
    this.restrictEnd,
    this.disabled,
    this.ev,
    this.motorScooter,
    this.paid,
    this.notes
  });
}
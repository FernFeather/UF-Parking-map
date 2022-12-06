import 'package:flutter/material.dart';
import 'package:parkings_/provider/google_sign_in.dart';
import 'package:parkings_/screens/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'services/parking_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ParkingDatabaseService.startEventListener();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //MyApp({super.key});
  //final locatorService = geolocateService();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        //return FutureProvider(
        //initialData: null,
        create: (context) => GoogleSignInProvider(),
        //create: (context) => locatorService.getLocation(),
        child: MaterialApp(
          title: 'Parkbois',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          //home: const MyHomePage(title: 'Parkkkkkkoings'),
          home: HomePage(),
        ),
        //);
      );
}

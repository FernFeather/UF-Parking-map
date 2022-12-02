import 'package:flutter/material.dart';
import 'package:parkings_/screens/Search.dart';
import 'package:parkings_/services/geolocateService.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final locatorService = geolocateService();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      initialData: null,
      create: (context) => locatorService.getLocation(),
      child: MaterialApp(
        title: 'Parkbois',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //home: const MyHomePage(title: 'Parkkkkkkoings'),
        home: Search(),
      ),
    );
  }
}

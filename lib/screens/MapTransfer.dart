import 'package:flutter/material.dart';
import 'package:parkings_/screens/HomePage.dart';
import 'package:parkings_/services/geolocateService.dart';
import 'package:provider/provider.dart';

class MapTransfer extends StatelessWidget {
  MapTransfer({super.key});
  final locatorService = geolocateService();

  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      initialData: null,
      create: (context) => locatorService.getLocation(),
      child: MaterialApp(
        title: 'UF Parking',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Search(),
      ),
    );
  }
}

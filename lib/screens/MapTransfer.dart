import 'package:flutter/material.dart';
import 'package:parkings_/screens/Search.dart';
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

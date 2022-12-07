import 'package:flutter/material.dart';
import 'package:uf_parking_map/screens/home_page.dart';
import 'package:uf_parking_map/services/geolocate_service.dart';
import 'package:provider/provider.dart';

class MapTransfer extends StatelessWidget {
  MapTransfer({super.key});
  final locatorService = GeolocateService();

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
        home: const Search(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parkings_/screens/MapTransfer.dart';
import 'package:parkings_/screens/SignUpWidget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
          body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return MapTransfer();
          } else if (snapshot.hasError) {
            return Center(child: Text('Something Went Wrong!'));
          } else {
            return SignUpWidget();
          }
        },
      ));
}

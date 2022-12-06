import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parkings_/screens/MapTransfer.dart';
import 'package:parkings_/screens/Search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parkings_/provider/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('Log in'),
          centerTitle: true,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  "UF Parking",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: MediaQuery.of(context).size.width * 0.20),
                ),
              ),
              Center(
                child: Text(
                  "Map",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: MediaQuery.of(context).size.width * 0.20),
                ),
              ),

              //Image.asset('assets/logoText.png'),
              Image.asset(
                'Florida_Gators_gator_logo.svg.png',
                height: MediaQuery.of(context).size.width * 0.85,
                width: MediaQuery.of(context).size.width * 0.85,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height / 14,
                child: SignInButton(
                  Buttons.GoogleDark,
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.googleLogin();
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(), backgroundColor: Colors.grey),
                child: Text('Continue without signing in'),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MapTransfer()));
                },
              ),
            ]),
      );
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parkings_/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Spacer(),
        //FlutterLogo(size: 120),
        //Spacer(),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
            minimumSize: Size(double.infinity, 50),
          ),
          icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
          label: Text('Sign In with Google'),
          onPressed: () {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.googleLogin();
          },
        ),
      ]));
}

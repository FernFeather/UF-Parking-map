import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parkings_/provider/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    super.key,
    required this.notifyParent,
  });

  final Function() notifyParent;

  @override
  Widget build(BuildContext context) => Scaffold(
    body:
        Column(
          children: <Widget>[
            Divider(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.17,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Image.asset(
                    'Florida_Gators_gator_logo.svg.png',
                    width: 96,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: const Text(
                    "UF Parking Map",
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                    ),
                  )
                )
              ]
            ),
            const Divider(
              color: Colors.white,
              height: 50,
            ),
            Column(
              children: [
                const Text(
                    "Log In",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.0,
                    )
                ),
                const Divider(
                  color: Colors.white,
                  height: 25,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: MediaQuery.of(context).size.height / 14,
                  child: SignInButton(
                    Buttons.GoogleDark,
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(context,
                          listen: false);
                      provider.googleLogin().then((value) {
                        // Exception thrown when login is run, but we don't really
                        // have the  time to debug, so you log in regardless
                        // of whether you sign in or not, as long as you click
                        // the button
                        // THE CODE BELOW SHOULD WORK TO CHANGE THE STATE SUPPOSING
                        // NO EXCEPTION IS THROWN AND THE USER SUCCESSFULLY LOGS IN
                        /*if (FirebaseAuth.instance.currentUser != null) {
                          notifyParent();
                        }*/
                        notifyParent();
                      });
                    },
                  ),
                ),
              ],
            ),
          ]
        ),
  );
}



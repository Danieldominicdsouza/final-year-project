import 'package:flutter/material.dart';
import 'package:movie_app/pages/authentication/loginScreen.dart';
import 'package:movie_app/pages/authentication/registerScreen.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn == true
        ? RegisterPage(
            toggleView: toggleView,
          )
        : LoginPage(
            toggleView: toggleView,
          );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_mate/src/screens/authentication/loginScreen.dart';
import 'package:movie_mate/src/screens/authentication/registerScreen.dart';

class AuthenticationToggler extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<AuthenticationToggler> {
  bool showSignIn = false;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignIn == true
        ? LoginScreen(
            toggleView: toggleView,
          )
        : RegisterScreen(
            toggleView: toggleView,
          );
  }
}

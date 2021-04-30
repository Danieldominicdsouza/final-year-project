import 'package:flutter/material.dart';
import 'package:movie_mate/src/models/user.dart';
import 'package:movie_mate/src/screens/authentication/authenticationToggler.dart';
import 'package:movie_mate/src/screens/beta_homeScreen.dart';
import 'package:movie_mate/src/screens/homeScreen.dart';
import 'package:provider/provider.dart';

class AuthState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    print(user);

    return user == null ? AuthenticationToggler() : HomeScreen(); //TestHomeScreen();
  }
}

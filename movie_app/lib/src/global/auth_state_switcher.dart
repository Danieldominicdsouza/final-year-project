import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_mate/src/models/user.dart';
import 'package:movie_mate/src/screens/authentication/authentication_toggler.dart';
import 'package:movie_mate/src/screens/home_screen.dart';
import 'package:movie_mate/src/screens/new_user_screen.dart';
import 'package:movie_mate/src/services/database_service.dart';
import 'package:movie_mate/src/services/user_data_service.dart';
import 'package:provider/provider.dart';

class AuthState extends StatelessWidget {
  static const pageRouteId = '/auth';
  static bool newUser = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    print(user);

    if (user == null)
      return AuthenticationToggler();
    else {
      if (newUser)
        return NewUserScreen();
      else
        return HomeScreen();
    }

    // return user == null
    //     ? AuthenticationToggler()
    //     : HomeScreen(); //TestHomeScreen();
  }
}

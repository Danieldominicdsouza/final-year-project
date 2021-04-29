import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_mate/src/widgets/auth_custom_widgets.dart';

class VerfiyScreen extends StatefulWidget {
  @override
  _VerfiyScreenState createState() => _VerfiyScreenState();
}

class _VerfiyScreenState extends State<VerfiyScreen> {
  Timer timer;
  final _firebaseAuth = FirebaseAuth.instance;
  // final _authService = AuthService();
  // final _databaseService = DatabaseService();
  User _user;

  @override
  void initState() {
    super.initState();
    _user = _firebaseAuth.currentUser;
    print(_user);
    _user.sendEmailVerification();
    //_authService.verifyEmail();
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    //final _user = _firebaseAuth.currentUser;
    await _user.reload();
    if (_user.emailVerified) {
      //TODO : Check this out
      // Map<String, String> userInfoMap = {
      //   'name': _user.displayName,
      //   'email': _user.email
      // };
      // _databaseService.updateUserInfo(userInfoMap);
      // timer.cancel();
      // print(
      //     'Registration Succesful of ${_user.displayName} with email ${_user.email}');
      timer.cancel();
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Center(
        child: Container(
          height: screenSize.height - 400,
          width: screenSize.width - 60,
          decoration: goldenContainerBoxDecoration(),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'An Email has has been sent to ${_user.email}',
                  style: TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Please verify',
                  style: TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

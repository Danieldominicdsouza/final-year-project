import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_mate/src/services/authenticaitonService.dart';

class VerfiyScreen extends StatefulWidget {
  @override
  _VerfiyScreenState createState() => _VerfiyScreenState();
}

class _VerfiyScreenState extends State<VerfiyScreen> {
  Timer timer;
  final _firebaseAuth = FirebaseAuth.instance;
  final _authService = AuthService();
  User _user;

  @override
  void initState() {
    super.initState();
    _authService.verifyEmail();
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
    _user = _firebaseAuth.currentUser;
    await _user.reload();
    if (_user.emailVerified) {
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
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(colors: [
                //Color(0xFF462523), //1
                Color(0xFF512F27), //2
                Color(0xFF6C4730), //3
                Color(0xFF956B3E), //4
                Color(0xFFBC8E4C),
                Color(0xFFCA9A51), //5
                Color(0xFFE2C167), //6
                Color(0xFFEDD372), //7
                Color(0xFFF0D874), //8
                Color(0xFFF6E27A), //9
                Color(0xFFF6E68C),
                Color(0xFFF6E589), //10
                Color(0xFFF6EEAF),
                Color(0xFFF6F2C0), //11
                Color(0xFFF6EEAF),
                Color(0xFFF6E589), //10
                Color(0xFFF6E68C),
                Color(0xFFF6E27A), //9
                Color(0xFFF0D874), //8
                Color(0xFFEDD372), //7
                Color(0xFFE2C167), //6
                Color(0xFFCA9A51), //5
                Color(0xFFBC8E4C),
                Color(0xFF956B3E), //4
                Color(0xFF6C4730), //3
                Color(0xFF512F27), //2
                //Color(0xFF462523), //1
              ])),
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

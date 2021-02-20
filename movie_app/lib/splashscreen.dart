import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_app/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () => main());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.amber, width: 2)),
            child: Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/launch_icon.png'),
                      width: 100,
                      height: 100,
                    ),
                    Text(
                      'Movie Magic',
                      style: TextStyle(
                          fontFamily: 'RobotoCondensed',
                          fontSize: 20,
                          color: Colors.redAccent,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1, 2),
                              color: Color.fromARGB(80, 255, 255, 255),
                            ),
                          ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}

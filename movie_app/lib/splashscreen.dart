import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_app/homeScreen.dart';
import 'package:movie_app/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 4),
      () => {
        Navigator.pushNamed(context, '/home'),
      },
    );
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
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
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
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Color.fromARGB(200, 255, 26, 26),
                                  //color: Colors.redAccent,
                                  letterSpacing: 1,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(1, 2),
                                      color: Color.fromARGB(80, 255, 255, 255),
                                      blurRadius: 3,
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Expanded(
                        flex: 1,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.amber),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}

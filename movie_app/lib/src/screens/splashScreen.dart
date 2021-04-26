import 'dart:async';

import 'package:flutter/material.dart';

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
        Navigator.of(context).pushReplacementNamed('/auth'),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.zero,
        // decoration:
        //     BoxDecoration(border: Border.all(color: Colors.amber, width: 2)),
        child: Scaffold(
          backgroundColor: Colors.grey[900],
          body: Center(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image(
                          image: AssetImage('assets/launch_icon.png'),
                          width: 100,
                          height: 100,
                        ),
                        SizedBox(
                          height: 200,
                        ),
                        Text(
                          'MovieMate',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              //color: Color.fromARGB(200, 255, 26, 26),
                              color: Colors.amber,
                              letterSpacing: 1,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(1, 2),
                                  color: Colors
                                      .black, //Color.fromARGB(80, 255, 255, 255),
                                  blurRadius: 3,
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Expanded(
                    flex: 1,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.amberAccent),
                    ),
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

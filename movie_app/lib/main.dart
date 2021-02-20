import 'package:flutter/material.dart';
import 'package:movie_app/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
      },
    );
  }
}

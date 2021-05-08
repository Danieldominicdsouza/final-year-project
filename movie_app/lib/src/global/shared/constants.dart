import 'package:flutter/material.dart';

const appBarText = Text(
  "MovieMate",
  style: TextStyle(
      color: Colors.amber,
      fontFamily: 'RobotoCondensed',
      fontWeight: FontWeight.w600,
      shadows: <Shadow>[
        Shadow(
          offset: Offset(1.0, 1.5),
          color: Colors.black, // Color.fromARGB(80, 255, 255, 255),
          blurRadius: 1,
        ),
      ]),
  textAlign: TextAlign.start,
);

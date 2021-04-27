import 'package:flutter/material.dart';

enum AppTheme {
  DefaultLight,
  DefaultDark,
  BlueLight,
  BlueDark,
}

final appThemeData = {
  AppTheme.DefaultLight:
      ThemeData(brightness: Brightness.light, primaryColor: Colors.white),
  AppTheme.DefaultDark:
      ThemeData(brightness: Brightness.dark, primaryColor: Colors.black),
  AppTheme.BlueLight: ThemeData(
      brightness: Brightness.light, primaryColor: Colors.blueGrey[900]),
  AppTheme.BlueDark:
      ThemeData(brightness: Brightness.dark, primaryColor: Color(0xFF002D41)),
};

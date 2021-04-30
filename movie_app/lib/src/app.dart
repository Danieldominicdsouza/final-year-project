import 'package:flutter/material.dart';
import 'package:movie_mate/src/screens/beta_homeScreen.dart';
import 'package:movie_mate/src/services/authValidation_bloc.dart';
import 'package:movie_mate/src/services/authenticationService.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';
import 'screens/homeScreen.dart';
import 'screens/splashScreen.dart';
import 'services/authStateSwitcher.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser>.value(
      value: AuthService()
          .user, // Stream of user Check AuthService class Stream<Myser>
      initialData: null,
      child: Provider(
        create: (context) => AuthValidationBloc(),
        child: MaterialApp(
          title: 'MovieMate',
          theme: ThemeData(
            accentColor: Colors.amber,
            primaryColor: Colors.black,
            //brightness: Brightness.dark,
          ),
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => SplashScreen(),
            '/home': (context) => HomeScreen(),
            '/testhome': (context) => TestHomeScreen(),
            '/auth': (context) => AuthState(),
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_mate/src/screens/authentication/verifyScreen.dart';
import 'package:movie_mate/src/services/authenticaitonService.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';
import 'screens/authentication/authenticationToggler.dart';
import 'screens/homeScreen.dart';
import 'screens/splashScreen.dart';
import 'services/authStateSwitcher.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser>.value(
      value: AuthService().user,
      initialData: null,
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
          '/auth': (context) => AuthState(),
          '/authToggle': (context) => AuthenticationToggler(),
          '/verify': (context) => VerfiyScreen(),
        },
      ),
    );
  }
}

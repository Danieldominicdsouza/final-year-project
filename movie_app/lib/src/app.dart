import 'package:flutter/material.dart';
import 'package:movie_mate/src/screens/beta_home_screen.dart';
import 'package:movie_mate/src/blocs/auth_validation_bloc.dart';
import 'package:movie_mate/src/services/authentication_service.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'global/auth_state_switcher.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => AuthValidationBloc()),
        StreamProvider<MyUser>.value(
            value: AuthService().user, initialData: null),
      ],
      child: MaterialApp(
        title: 'MovieMate',
        theme: ThemeData(
          accentColor: Colors.amber,
          primaryColor: Colors.black,
          brightness: Brightness.dark,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => SplashScreen(),
          '/home': (context) => HomeScreen(),
          '/testhome': (context) => TestHomeScreen(),
          '/auth': (context) => AuthState(),
        },
      ),
    );
  }
}

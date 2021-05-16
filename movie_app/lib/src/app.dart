import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_mate/src/screens/beta_home_screen.dart';
import 'package:movie_mate/src/blocs/auth_validation_bloc.dart';
import 'package:movie_mate/src/screens/new_user_screen.dart';
import 'package:movie_mate/src/services/authentication_service.dart';
import 'package:movie_mate/src/services/database_service.dart';
import 'package:provider/provider.dart';

import 'models/genre.dart';
import 'models/user.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'global/auth_state_switcher.dart';
import 'services/genre_list_service.dart';
import 'services/user_data_service.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => AuthValidationBloc()),
        StreamProvider<MyUser>.value(
            value: AuthService().user, initialData: null),
        // StreamProvider<MyUser>.value(
        //     value: UserDataService()
        //         //userUid: FirebaseAuth.instance.currentUser.uid)
        //         .updatedUsers,
        //     initialData: null),

        StreamProvider<List<Genre>>(
            create: (context) => GenreListService().genres,
            initialData: []), //Use this to pass ListGenre through whole app
      ],
      child: MaterialApp(
        title: 'MovieMate',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          accentColor: Colors.amber,
          primaryColor: Colors.black,
          brightness: Brightness.dark,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: AuthState.pageRouteId,
        routes: {
          '/splash': (context) => SplashScreen(),
          HomeScreen.pageRouteId: (context) => HomeScreen(),
          //'/home': (context) => HomeScreen(),
          '/testHome': (context) => TestHomeScreen(),
          AuthState.pageRouteId: (context) => AuthState(),
          //'/auth': (context) => AuthState(),
          NewUserScreen.pageRouteId: (context) => NewUserScreen(),
        },
      ),
    );
  }
}

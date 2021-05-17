import 'package:flutter/material.dart';
import 'package:movie_mate/src/screens/beta_home_screen.dart';
import 'package:movie_mate/src/blocs/auth_validation_bloc.dart';
import 'package:movie_mate/src/screens/new_user_screen.dart';
import 'package:movie_mate/src/services/authentication_service.dart';

import 'package:movie_mate/src/services/movie_service.dart';
import 'package:provider/provider.dart';

import 'models/disliked_movie.dart';
import 'models/genre.dart';
import 'models/liked_movie.dart';
import 'models/user.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';
import 'global/auth_state_switcher.dart';
import 'services/genre_list_service.dart';

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
        StreamProvider<List<LikedMovie>>.value(
            value: MovieService().likedMovies, initialData: []),
        StreamProvider<List<DislikedMovie>>.value(
            value: MovieService().dislikedMovies, initialData: []),
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
        initialRoute: SplashScreen.pageRouteId,
        routes: {
          SplashScreen.pageRouteId: (context) => SplashScreen(),
          //'/splash': (context) => SplashScreen(),
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

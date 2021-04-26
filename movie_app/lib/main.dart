import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'src/app.dart';

//void main() => runApp(MyApp());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

// class MyApp extends StatelessWidget {
  // This widget is the root of your application.

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'MovieMate',
//       initialRoute: '/splash',
//       routes: {
//         '/splash': (context) => SplashScreen(),
//         '/home': (context) => HomeScreen(),
//         '/authToggle': (context) => AuthenticationToggler(),
//         '/auth': (context) => AuthState(),
//       },
//     );
//   }
// }

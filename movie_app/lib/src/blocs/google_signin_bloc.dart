import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_mate/src/services/authentication_service.dart';
import 'package:movie_mate/src/services/database_service.dart';

class GoogleSignInBloc extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //Stream<User> get user => _authService.currentUserState;

  //Google Auth logic which returns a google user which we convert to firebase user passing the idToken and accessToken
  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      //Firebase signIn
      _authService.signInWithCredential(authCredential);
    } catch (error) {}
  }

  signOutFromGoogle() {
    //_googleSignIn.disconnect();
    _authService.signOut();
  }
}

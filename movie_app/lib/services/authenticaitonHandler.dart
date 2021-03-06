import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/classes/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  MyUser _myUserFromFB(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  //Auth change Firebase user stream
  Stream<MyUser> get user {
    return _auth
        .authStateChanges()
        //.map((User user) => _myUserFromFB(user));
        .map(_myUserFromFB);
  }

  //Sign in Anonymously
  Future signInAnon() async {
    try {
      UserCredential userResult = await _auth.signInAnonymously();
      User user = userResult.user;

      return _myUserFromFB(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
  // Sign in with email and password

  //Register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = userResult.user;
      return _myUserFromFB(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out anonymously
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Sign out with email and password
}

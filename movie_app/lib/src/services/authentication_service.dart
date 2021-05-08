import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_mate/src/models/user.dart';
import 'package:movie_mate/src/services/database_service.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool _isAuthenticating = false;

  bool get isAuthenticating => _isAuthenticating;

  set isAuthenticating(bool isAuthenticatingState) {
    _isAuthenticating = isAuthenticatingState;
    notifyListeners();
  }

  //Creates MyUser object from a Firebase User
  MyUser _myUserFromFirebase(User user) {
    return user != null
        ? MyUser(
            uid: user.uid,
            email: user.email,
            username: user.displayName ?? 'username',
            photoURL: user.photoURL ?? '')
        : null;
  }

  //Auth change Firebase user stream
  Stream<MyUser> get user {
    return _firebaseAuth.authStateChanges().map(_myUserFromFirebase);
    // OR
    //.map((User user) => _myUserFromFirebase(user));
  }

  //Auth state stream
  Stream<User> get currentUserState => _firebaseAuth.authStateChanges();

  //Sign in Anonymously/Guest user
  Future signInAnon() async {
    try {
      UserCredential userResult = await _firebaseAuth.signInAnonymously();
      User user = userResult.user;

      return _myUserFromFirebase(user);
    } on FirebaseAuthException catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userResult = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User user = userResult.user;
      return _myUserFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      return e.message;
      //return null;
    }
  }

  //Register with email and password
  Future registerWithEmailAndPassword(
      String email, String password, String username) async {
    try {
      UserCredential userResult = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userResult.user;

      //create new document for user with userUid
      await DatabaseService(userUid: user.uid)
          .updateUserData(name: username, email: email);

      return _myUserFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return e.message;
      //return null;
    }
  }

  //Common function that can be used with Google, Facebook, etc.
  Future signInWithCredential(AuthCredential credential) async {
    try {
      UserCredential userResult =
          await _firebaseAuth.signInWithCredential(credential);
      User user = userResult.user;
      await DatabaseService(userUid: user.uid).updateUserData(
          name: user.displayName, email: user.email, photoURL: user.photoURL);
      return _myUserFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return e.message;
    }
  }

  // Sign out
  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (error) {
      print(error.toString());
      return null;
    }
  }

  //Email verification mail once the user is created
  Future verifyEmail() async {
    try {
      User user = _firebaseAuth.currentUser;
      return await user.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Reset password
  Future resetPassword(String email) async {
    try {
      return await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  // String usernameValidation(String username) {
  //   return username.isNotEmpty && username.length > 4
  //       ? null
  //       : 'Enter a valid Username';
  // }
  //
  // String emailValidation(String email) {
  //   if (email != null && EmailValidator.validate(email))
  //   // RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
  //   //     .hasMatch(email)) {
  //   {
  //     return null;
  //   } else {
  //     return 'Enter a valid Email';
  //   }
  // }
  //
  // String passwordValidation(String password) {
  //   return password.length > 6 ? null : 'Enter a password longer than 6 chars';
  // }
}

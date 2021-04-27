import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_mate/src/models/user.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  MyUser _myUserFromFirebase(User user) {
    return user != null ? MyUser(uid: user.uid, email: user.email) : null;
  }

  //Auth change Firebase user stream
  Stream<MyUser> get user {
    return _firebaseAuth.authStateChanges().map(_myUserFromFirebase);
    // OR
    //.map((User user) => _myUserFromFirebase(user));
  }

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
      print(_myUserFromFirebase(user));
      return _myUserFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //Register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userResult = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userResult.user;
      await verifyEmail();
      print(_myUserFromFirebase(user));
      return _myUserFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
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

  Future verifyEmail() async {
    try {
      User user = _firebaseAuth.currentUser;
      return await user.sendEmailVerification();
    } on FirebaseException catch (e) {
      print(e.toString());
      return null;
    }
  }

  String emailValidation(String email) {
    return email != null && EmailValidator.validate(email)
        ? null
        : 'Enter a valid Email';
  }

  String passwordValidation(String password) {
    return password.length > 6 ? null : 'Enter a password longer than 6 chars';
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_mate/src/global/auth_state_switcher.dart';
import 'package:movie_mate/src/models/genre.dart';
import 'package:movie_mate/src/models/user.dart';

class UserDataService extends ChangeNotifier {
  final String userUid;

  UserDataService({this.userUid});

  //Reference to collection called users in Firestore
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  //Get user stream
  Stream<MyUser> get updatedUsers {
    return userCollection
        .doc(userUid)
        .snapshots()
        .map(getUpdatedUserDataAsMyUser);
  }

  //Converts user doc in Firestore to MyUser object
  MyUser getUpdatedUserDataAsMyUser(DocumentSnapshot userSnapshot) {
    try {
      return MyUser(
        username: userSnapshot.data()['username'],
        email: userSnapshot.data()['email'],
        photoURL: userSnapshot.data()['photoURL'],
      );
    } catch (error) {
      return null;
      // return MyUser(
      //   username: 'no user',
      //   email: 'no email',
      //   photoURL: 'no photoURL',
      // );
    }
  }

  //Because update throws an error when no doc exists whereas set creates one even if one doesn't exist
  Future updateUserData({String name, String email, String photoURL}) async {
    try {
      return await userCollection.doc(userUid).update(
          {'username': name, 'email': email, 'photoURL': photoURL ?? ''});
    } catch (error) {
      AuthState.newUser = true;
      return await userCollection.doc(userUid).set(
        {'username': name, 'email': email, 'photoURL': photoURL ?? ''},
      );
    }
  }

  //Update User Genre Preference
  Future updateUserGenrePreference(List<Genre> genres) async {
    List<String> genreList = [];
    genres.forEach((genre) => genreList.add(genre.genre));
    return await userCollection.doc(userUid).update({
      'genre-preference': [genreList]
    });
  }
}

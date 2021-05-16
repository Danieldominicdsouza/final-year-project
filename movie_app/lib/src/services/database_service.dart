import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_mate/src/global/auth_state_switcher.dart';
import 'package:movie_mate/src/models/genre.dart';
import 'package:movie_mate/src/models/movie.dart';
import 'package:movie_mate/src/models/user.dart';

class DatabaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final String userUid;

  DatabaseService({this.userUid});

  //Collection references
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference movieCollection =
      FirebaseFirestore.instance.collection('movies');
  final CollectionReference genreCollection =
      FirebaseFirestore.instance.collection('genres');

  //This is not even used
  updateUserInfo(userInfoMap) {
    try {
      FirebaseFirestore.instance.collection('users').add(userInfoMap);
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  //try a try or if-else block where if fails to .update() then .set() it
  Future updateUserData({String name, String email, String photoURL}) async {
    try {
      return await userCollection.doc(_firebaseAuth.currentUser.uid).update(
          {'username': name, 'email': email, 'photoURL': photoURL ?? ''});
    } catch (error) {
      AuthState.newUser = true;
      return await userCollection.doc(_firebaseAuth.currentUser.uid).set(
        {'username': name, 'email': email, 'photoURL': photoURL ?? ''},
      );
    }
    // try {
    //   return await userCollection.doc(userUid).update(
    //       {'username': name, 'email': email, 'photoURL': photoURL ?? ''});
    // } catch (error) {
    //   AuthState.newUser = true;
    //   return await userCollection.doc(userUid).set(
    //     {'username': name, 'email': email, 'photoURL': photoURL ?? ''},
    //   );
    // }
    // return await userCollection.doc(userUid).set(
    //   {
    //     'name': name,
    //     'email': email,
    //     'photoURl': photoURL ?? ''
    //   }, //SetOptions(merge: true) //Use this to not overwrite data but add to it BUt
    // );
  }

  MyUser _getUserData() {
    dynamic userSnapshot =
        userCollection.doc(_firebaseAuth.currentUser.uid).snapshots;
    try {
      return MyUser(
        username: userSnapshot.data()['username'],
        email: userSnapshot.data()['email'],
        photoURL: userSnapshot.data()['photoURL'],
      );
    } catch (error) {
      return MyUser(
        username: 'no user',
        email: 'no email',
        photoURL: 'no photoURL',
      );
    }
    // try {
    //   dynamic result = userCollection.doc(userUid).get();
    //   return MyUser(
    //     username: result['name'],
    //     email: result['email'],
    //     photoURL: result['photoURL'],
    //   );
    // } catch (error) {
    //   return MyUser(
    //     username: 'error',
    //     email: 'error',
    //     photoURL: 'error',
    //   );
    // }
  }

  MyUser _getUpdatedUserData(DocumentSnapshot userSnapshot) {
    try {
      return MyUser(
        username: userSnapshot.data()['username'],
        email: userSnapshot.data()['email'],
        photoURL: userSnapshot.data()['photoURL'] ?? '',
      );
    } catch (error) {
      return MyUser(
        username: 'no user',
        email: 'no email',
        photoURL: 'no photoURL',
      );
    }
  }

  // Future updateUserPreferences(){
  //
  // }

  //Get user object
  MyUser get users {
    return _getUserData();
  }

  //Get user stream
  Stream<MyUser> get updatedUsers {
    return userCollection.doc(userUid).snapshots().map(_getUpdatedUserData);
  }

  //Get movies stream
  Stream<List<Movie>> get movies {
    return movieCollection.snapshots().map(_movieListFromSnapshot);
  }

  //Get genres stream
  Stream<List<Genre>> get genres {
    return movieCollection.snapshots().map(_genreListFromSnapshot);
  }

  //movie list from snapshot
  List<Movie> _movieListFromSnapshot(QuerySnapshot moviesSnapshot) {
    return moviesSnapshot.docs.map((movieDoc) {
      return Movie(
        movieID: movieDoc.data()['movie-id'],
        movieName: movieDoc.data()['movie-name'] ?? 'Movie Name',
        movieDescription: movieDoc.data()['description'] ?? 'Movie Description',
        movieLikes: movieDoc.data()['likes'] ?? 0,
        movieDislikes: movieDoc.data()['dislikes'] ?? 0,
        moviePosterPath: movieDoc.data()['posterURL'] ?? '',
        releaseDate: movieDoc.data()['initial-release'],
        language: movieDoc.data()['language'],
      );
    }).toList();
  }

  //genre list from snapshot
  List<Genre> _genreListFromSnapshot(QuerySnapshot genreSnapshot) {
    return genreSnapshot.docs.map((doc) {
      return Genre(
          genreID: doc.id ?? '',
          genre: doc.data()['genre-name'] ?? 'Genre Name',
          description: doc.data()['description'] ?? 'Genre Description',
          interestCount: doc.data()['interest-count'] ?? 0);
    }).toList();
  }
}

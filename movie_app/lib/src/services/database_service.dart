import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_mate/src/models/genre.dart';
import 'package:movie_mate/src/models/movie.dart';

class DatabaseService {
  final String userUid;

  DatabaseService({this.userUid});

  //Collection references
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference movieCollection =
      FirebaseFirestore.instance.collection('movies');
  final CollectionReference genreCollection =
      FirebaseFirestore.instance.collection('genres');

  getUserByUsername() {}
  updateUserInfo(userInfoMap) {
    try {
      FirebaseFirestore.instance.collection('users').add(userInfoMap);
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  //try a try or if-else block where if fails to .update() then .set() it
  Future updateUserData({String name, String email, String photoURL}) async {
    return await userCollection.doc(userUid).set(
      {
        'name': name,
        'email': email,
        'photoURl': photoURL ?? ''
      }, //SetOptions(merge: true) //Use this to not overwrite data but add to it BUt
    );
  }

  // Future updateUserPreferences(){
  //
  // }

  //Get users stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
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
        movieName: movieDoc.data()['movie-name'] ?? 'Movie Name',
        movieDescription: movieDoc.data()['description'] ?? 'Movie Description',
        movieLikes: movieDoc.data()['likes'] ?? 0,
        movieDislikes: movieDoc.data()['dislikes'] ?? 0,
        moviePosterPath: movieDoc.data()['posterURL'] ?? '',
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

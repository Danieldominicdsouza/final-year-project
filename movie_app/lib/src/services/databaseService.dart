import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_mate/src/models/movie.dart';

class DatabaseService {

  final String userUid;

  DatabaseService({this.userUid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference movieCollection = FirebaseFirestore.instance.collection('movies');


  getUserByUsername() {}
  updateUserInfo(userInfoMap) {
    try {
      FirebaseFirestore.instance.collection('users').add(userInfoMap);
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  Future updateUserData({String name, String email}) async{
    return await userCollection.doc(userUid).set({
      'name' : name,
      'email' : email,
    });
  }


  //Get users stream
  Stream<QuerySnapshot> get users {
    return userCollection.snapshots();
  }

  //Get movies stream
  Stream<List<Movie>> get movies {
    return movieCollection.snapshots().map(_movieListFromSnapshot);
  }

  //movie list from snapshot
  List<Movie> _movieListFromSnapshot(QuerySnapshot moviesSnapshot) {
    return moviesSnapshot.docs.map((movieDoc) {
      return Movie(
        movieID: movieDoc.id ?? '',
        movieName: movieDoc.data()['Movie-name'] ?? 'MovieName',
        movieDescription: movieDoc.data()['Description'] ?? 'Description',
        movieLikes: movieDoc.data()['Likes'] ?? 0,
        movieDislikes: movieDoc.data()['Dislikes'] ?? 0,
        moviePosterPath: movieDoc.data()['Access Token'] ?? '',
      );
    }).toList();
  }

}

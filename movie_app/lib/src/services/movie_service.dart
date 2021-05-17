import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_mate/src/models/disliked_movie.dart';
import 'package:movie_mate/src/models/movie.dart';
import '../models/liked_movie.dart';

class MovieService with ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // final CollectionReference movieCollection =
  //     FirebaseFirestore.instance.collection('movies');
  //
  // Future incrementLike(String movieId) async {
  //   DocumentSnapshot movieSnapshot = await movieCollection.doc(movieId).get();
  //   int likes = movieSnapshot.get('likes');
  //   likes++;
  //   movieCollection.doc(movieId).update({'likes': likes});
  //   print(likes.toString());
  // }
  //
  // Future decrementLike(String movieId) async {
  //   DocumentSnapshot movieSnapshot = await movieCollection.doc(movieId).get();
  //   int likes = movieSnapshot.get('likes');
  //   likes--;
  //   movieCollection.doc(movieId).update({'likes': likes});
  //   print(likes.toString());
  // }
  //
  // Future incrementDislike(String movieId) async {
  //   DocumentSnapshot movieSnapshot = await movieCollection.doc(movieId).get();
  //   int dislikes = movieSnapshot.get('dislikes');
  //   dislikes++;
  //   movieCollection.doc(movieId).update({'dislikes': dislikes});
  //   print(dislikes.toString());
  // }
  //
  // Future decrementDislike(String movieId) async {
  //   DocumentSnapshot movieSnapshot = await movieCollection.doc(movieId).get();
  //   int dislikes = movieSnapshot.get('dislikes');
  //   dislikes--;
  //   movieCollection.doc(movieId).update({'dislikes': dislikes});
  //   print(dislikes.toString());
  // }

  onMovieLiked(Movie movie) async {
    userCollection
        .doc(_firebaseAuth.currentUser.uid)
        .collection('likedMovies')
        .doc(movie.movieID)
        .set({
      'movie-id': movie.movieID,
      'movie-name': movie.movieName,
      'posterURL': movie.moviePosterPath,
      'liked': true,
    });
    //await incrementLike(movie.movieID);
  }

  onMovieRemoveLiked(Movie movie) async {
    userCollection
        .doc(_firebaseAuth.currentUser.uid)
        .collection('likedMovies')
        .doc(movie.movieID)
        .delete();
    // await decrementLike(movie.movieID);
  }

  onMovieRemoveLikedViaUid(String movieID) async {
    userCollection
        .doc(_firebaseAuth.currentUser.uid)
        .collection('likedMovies')
        .doc(movieID)
        .delete();
    // await decrementLike(movieID);
  }

  onMovieDisliked(Movie movie) async {
    userCollection
        .doc(_firebaseAuth.currentUser.uid)
        .collection('dislikedMovies')
        .doc(movie.movieID)
        .set({
      'movie-id': movie.movieID,
      'movie-name': movie.movieName,
      'posterURL': movie.moviePosterPath,
      'disliked': true,
    });
    // await incrementDislike(movie.movieID);
  }

  onMovieRemoveDisliked(Movie movie) async {
    userCollection
        .doc(_firebaseAuth.currentUser.uid)
        .collection('dislikedMovies')
        .doc(movie.movieID)
        .delete();
    // await decrementLike(movie.movieID);
  }

  onMovieRemoveDislikedViaUid(String movieID) async {
    userCollection
        .doc(_firebaseAuth.currentUser.uid)
        .collection('dislikedMovies')
        .doc(movieID)
        .delete();
    // await decrementLike(movieID);
  }

  //Getter
  Stream<List<LikedMovie>> get likedMovies {
    return userCollection
        .doc(_firebaseAuth.currentUser.uid)
        .collection('likedMovies')
        .snapshots()
        .map(likedMoviesFromSnapshot);
  }

  Stream<List<DislikedMovie>> get dislikedMovies {
    return userCollection
        .doc(_firebaseAuth.currentUser.uid)
        .collection('dislikedMovies')
        .snapshots()
        .map(dislikedMoviesFromSnapshot);
  }

  List<LikedMovie> likedMoviesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return LikedMovie(
        movieName: doc.data()['movie-name'],
        movieId: doc.data()['movie-id'],
        posterURL: doc.data()['posterURL'],
        liked: doc.data()['liked'],
      );
    }).toList();
  }

  List<DislikedMovie> dislikedMoviesFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return DislikedMovie(
        movieName: doc.data()['movie-name'],
        movieId: doc.data()['movie-id'],
        posterURL: doc.data()['posterURL'],
        disliked: doc.data()['disliked'],
      );
    }).toList();
  }
}

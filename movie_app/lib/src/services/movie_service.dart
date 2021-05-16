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

  onMovieLiked(Movie movie) {
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
  }

  onMovieRemoveLiked(Movie movie) {
    userCollection
        .doc(_firebaseAuth.currentUser.uid)
        .collection('likedMovies')
        .doc(movie.movieID)
        .delete();
  }

  onMovieDisliked(Movie movie) {
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
  }

  onMovieRemoveDisliked(Movie movie) {
    userCollection
        .doc(_firebaseAuth.currentUser.uid)
        .collection('dislikedMovies')
        .doc(movie.movieID)
        .delete();
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

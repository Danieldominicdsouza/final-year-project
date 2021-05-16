import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie_mate/src/models/movie.dart';

class GenreMoviesListService {
  final String genre;

  final CollectionReference genreCollection =
      FirebaseFirestore.instance.collection('genres');

  GenreMoviesListService({this.genre});

  // Stream<List<Movie>> get genres {
  //   return genreCollection.snapshots().map(_genreListFromSnapshot);
  // }

  //Get movies stream
  // Stream<List<Movie>> get movies {
  //   return movieCollection.snapshots().map(_movieListFromSnapshot);
  // }

  //Get movies stream
  Stream<List<Movie>> get movies {
    //print('${genre}_movies'.replaceAll(' ', '-').toLowerCase());
    return genreCollection
        .doc(genre)
        .collection('${genre}_movies'.replaceAll(' ', '-').toLowerCase())
        .snapshots()
        .map(_movieListFromSnapshot);
  }

  //movie list from snapshot
  List<Movie> _movieListFromSnapshot(QuerySnapshot moviesSnapshot) {
    // List<String> castList = [];
    // List<String> directorList = [];
    // List<String> screenplayList = [];
    // moviesSnapshot.docs.forEach((movie) {
    //   //castList = movie.data()['cast'][0][1][2] as List<String>;
    //   movie.data()['cast'].forEach((actor) => castList.add(actor));
    //   movie
    //       .data()['directors']
    //       .forEach((director) => directorList.add(director));
    //   movie
    //       .data()['screenplay']
    //       .forEach((screenplay) => screenplayList.add(screenplay));
    // });
    return moviesSnapshot.docs.map((movieDoc) {
      List<String> castList = [];
      List<String> directorList = [];
      List<String> screenplayList = [];

      movieDoc.data()['cast'].forEach((actor) => castList.add(actor));
      movieDoc
          .data()['directors']
          .forEach((director) => directorList.add(director));
      movieDoc
          .data()['screenplay']
          .forEach((screenplay) => screenplayList.add(screenplay));

      return Movie(
        movieID: movieDoc.data()['movie-id'],
        movieName: movieDoc.data()['movie-name'] ?? 'Movie Name',
        movieDescription: movieDoc.data()['description'] ?? 'Movie Description',
        movieLikes: movieDoc.data()['likes'] ?? 0,
        movieDislikes: movieDoc.data()['dislikes'] ?? 0,
        moviePosterPath: movieDoc.data()['posterURL'] ?? '',
        releaseDate: movieDoc.data()['initial-release'],
        language: movieDoc.data()['language'],
        cast: castList,
        directors: directorList,
        screenplay: screenplayList,
        //cast: movieDoc.data()['cast'],
        // directors: movieDoc.data()['directors'],
        // screenplay: movieDoc.data()['screenplay'],
      );
    }).toList();
  }
}

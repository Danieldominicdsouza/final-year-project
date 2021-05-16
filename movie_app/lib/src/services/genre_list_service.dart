import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_mate/src/models/genre.dart';

class GenreListService extends ChangeNotifier {
  final CollectionReference genreCollection =
      FirebaseFirestore.instance.collection('genres');
  //List<Genre> genreList = [];

  //List<Genre> get listOfGenres => getGenreList();

  // getGenreList() {
  //   try {
  //     genreCollection.snapshots().map((genre) {}).toList();
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }

  Stream<List<Genre>> get genres {
    return genreCollection.snapshots().map(_genreListFromSnapshot);
  }

  //genre list from snapshot
  List<Genre> _genreListFromSnapshot(QuerySnapshot genreSnapshot) {
    return genreSnapshot.docs.map((doc) {
      return Genre(
        genreID: doc.id ?? '',
        genre: doc.data()['genre-name'] ?? 'Genre Name',
        description: doc.data()['description'] ?? 'Genre Description',
        interestCount: doc.data()['interest-count'] ?? 0,
        posterURL: doc.data()['posterURL'],
      );
    }).toList();
  }

  void updateUserGenrePreference(List<Genre> genre) {}
}

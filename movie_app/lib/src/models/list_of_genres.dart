import 'package:flutter/material.dart';
import 'package:movie_mate/src/models/genre.dart';

class ListOfGenres extends ChangeNotifier {
  List<Genre> listOfGenres = [];
  static List<Genre> selectedGenres = [];

  // ListOfGenres({this.listOfGenres});

  void addGenres(Genre genre) {
    listOfGenres.add(genre);
    notifyListeners();
  }

  void updatePreference(Genre genre) {
    genre.togglePreference();
    getSelectedGenres(genre);
    notifyListeners();
  }

  void getSelectedGenres(Genre genre) {
    if (genre.isPreferred) {
      selectedGenres.add(genre);
    } else {
      if (selectedGenres.contains(genre)) {
        selectedGenres.remove(genre);
      }

      // selectedGenres.forEach((genre) {
      //   if (genre.isPreferred) {
      //     selectedGenres.add(genre);
      //   } else {
      //     if (selectedGenres.contains(genre)) {
      //       selectedGenres.remove(genre);
      //     }
      //   }
      // });
      //return selectedGenres;
    }
  }
}

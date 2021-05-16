import 'package:flutter/cupertino.dart';

class Genre extends ChangeNotifier {
  final String genreID;
  final String genre;
  final int interestCount;
  final String description;
  final String posterURL;
  bool isPreferred;

  Genre(
      {this.genreID,
      this.genre,
      this.interestCount,
      this.description,
      this.isPreferred = false, //By default all are not preferred
      this.posterURL});

  void togglePreference() {
    isPreferred = !isPreferred;
    //return isPreferred;
    notifyListeners();
  }
}

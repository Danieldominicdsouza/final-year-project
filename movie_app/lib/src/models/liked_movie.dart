import 'package:flutter/cupertino.dart';

class LikedMovie extends ChangeNotifier {
  final String movieName;
  final String movieId;
  final String posterURL;
  bool liked;

  LikedMovie({this.movieName, this.movieId, this.liked, this.posterURL});
}

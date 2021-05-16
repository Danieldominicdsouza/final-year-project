import 'package:flutter/cupertino.dart';

class DislikedMovie with ChangeNotifier {
  final String movieName;
  final String movieId;
  final String posterURL;
  bool disliked;

  DislikedMovie({this.movieName, this.movieId, this.disliked, this.posterURL});
}

import 'package:flutter/cupertino.dart';

class Movie {
  final String movieName;
  final String movieID;
  final int movieLikes;
  final int movieDislikes;
  final String movieDescription;
  final String moviePosterPath;
  final String releaseDate;
  final String language;
  final List<String> cast;
  final List<String> directors;
  final List<String> screenplay;

  Movie({
    this.movieID,
    this.movieName,
    this.movieDescription,
    this.moviePosterPath,
    this.movieLikes,
    this.movieDislikes,
    this.releaseDate,
    this.language,
    this.cast,
    this.directors,
    this.screenplay,
  });

  Map<String, dynamic> toMap() {
    return {
      'movie-id': movieID,
      'movie-name': movieName,
    };
  }
}

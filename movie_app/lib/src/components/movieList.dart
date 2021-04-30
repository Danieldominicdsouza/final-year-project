import 'package:flutter/material.dart';
import 'package:movie_mate/src/components/movieTile.dart';
import 'package:movie_mate/src/models/movie.dart';
import 'package:provider/provider.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    final List<Movie> movies = Provider.of<List<Movie>>(context) ?? [];

    movies.forEach((movie) {print(movie.movieName+'\n'+movie.moviePosterPath+'\n'+movie.movieDescription+'\n'+movie.movieLikes.toString());});
    return ListView.builder(
        itemCount: movies.length ?? 0,
        itemBuilder: (context, index){
      return MovieTile(movie: movies[index]);
    });
  }
}


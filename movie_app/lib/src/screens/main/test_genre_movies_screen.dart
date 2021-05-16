import 'package:flutter/material.dart';
import 'package:movie_mate/src/components/movie_tile.dart';
import 'package:movie_mate/src/models/movie.dart';
import 'package:movie_mate/src/services/genre_movies_list_service.dart';

class TestGenreMoviesScreen extends StatefulWidget {
  final String genre;

  const TestGenreMoviesScreen({Key key, @required this.genre})
      : super(key: key);

  @override
  _TestGenreMoviesScreenState createState() => _TestGenreMoviesScreenState();
}

class _TestGenreMoviesScreenState extends State<TestGenreMoviesScreen> {
  List<Widget> movieList = [];

  @override
  Widget build(BuildContext context) {
    final genreMovieListService = GenreMoviesListService(genre: widget.genre);

    return StreamBuilder<List<Movie>>(
        stream: genreMovieListService.movies,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          snapshot.data.forEach((movie) {
            movieList.add(MovieTile(movie: movie));
          });
          return Scaffold(
              appBar: AppBar(
                title: Text(widget.genre),
              ),
              body: ListView(
                children: movieList,
              )
              // ListView.builder(
              //   itemCount: snapshot.data.length,
              //   itemBuilder: (context, index) {
              //     return MovieTile(movie: snapshot.data[index]);
              //   },
              // ),
              );
        });
  }
}

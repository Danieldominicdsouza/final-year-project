import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_mate/src/components/movie_tile.dart';
import 'package:movie_mate/src/components/new_user/genre_list.dart';
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

  Widget _preferenceButton(String buttonText, IconData iconData, Color color) {
    return GestureDetector(
      onTap: () async {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('You have ${buttonText}d this movie')));

        await Future.delayed(Duration(milliseconds: 800));
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
      },
      child: Container(
        height: 45.0,
        width: 100.0,
        //color: Colors.amber, //Adding this causes error because it conflicts with box decoration
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              iconData,
              color: color,
            ),
            //Adding an Icon Button overrides the functionality of GestureDetector and does nothing if onPressed is Empty
            Text(
              buttonText,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

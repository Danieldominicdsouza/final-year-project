import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_mate/src/components/movie_tile.dart';
import 'package:movie_mate/src/models/movie.dart';
import 'package:movie_mate/src/services/genre_movies_list_service.dart';

class GenreMoviesScreen extends StatefulWidget {
  final String genre;

  const GenreMoviesScreen({Key key, @required this.genre}) : super(key: key);

  @override
  _GenreMoviesScreenState createState() => _GenreMoviesScreenState();
}

class _GenreMoviesScreenState extends State<GenreMoviesScreen> {
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
            body: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Stack(
                    //children: [Text(snapshot.data.first.movieName)]
                    children: movieList,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _preferenceButton('Dislike', FontAwesomeIcons.timesCircle,
                          Colors.redAccent),
                      _preferenceButton(
                          'Like', FontAwesomeIcons.heart, Colors.green),
                    ],
                  ),
                )
              ],
            ),
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

        // setState(() {
        //   movieList.remove(movie);
        // });

        // setState(() {
        //   _movieNumber = Random().nextInt(4) + 1;
        // });
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

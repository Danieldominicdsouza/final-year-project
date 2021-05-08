import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_mate/src/models/movie.dart';

class MovieTile extends StatefulWidget {
  final Movie movie;

  MovieTile({this.movie});

  @override
  _MovieTileState createState() => _MovieTileState();
}

class _MovieTileState extends State<MovieTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: Column(
          children: [
            Text(
              widget.movie.movieName,
              style: TextStyle(color: Colors.white),
            ),
            Image(image: NetworkImage(widget.movie.moviePosterPath))
          ],
        ),
      ),
    );
  }
}

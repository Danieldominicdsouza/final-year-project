import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_mate/src/models/disliked_movie.dart';
import 'package:movie_mate/src/models/liked_movie.dart';
import 'package:movie_mate/src/models/movie.dart';
import 'package:movie_mate/src/services/movie_service.dart';
import 'package:provider/provider.dart';

import 'movie_info.dart';

class MovieTile extends StatefulWidget {
  final Movie movie;

  MovieTile({this.movie});

  @override
  _MovieTileState createState() => _MovieTileState();
}

class _MovieTileState extends State<MovieTile> {
  final MovieService movieService = MovieService();
  bool liked = false;
  bool disliked = false;

  toggleLike() {
    liked = !liked;
    if (liked) {
      movieService.onMovieLiked(widget.movie);
    } else {
      movieService.onMovieRemoveLiked(widget.movie);
    }
  }

  toggleDislike() {
    disliked = !disliked;
    if (disliked) {
      movieService.onMovieDisliked(widget.movie);
    } else {
      movieService.onMovieRemoveDisliked(widget.movie);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<LikedMovie> listOfLikedMovies =
        Provider.of<List<LikedMovie>>(context);
    final List<DislikedMovie> listOfDislikedMovies =
        Provider.of<List<DislikedMovie>>(context);

    listOfLikedMovies.forEach((movie) {
      if (widget.movie.movieID == movie.movieId)
        setState(() {
          liked = true;
        });
    });

    listOfDislikedMovies.forEach((movie) {
      if (widget.movie.movieID == movie.movieId)
        setState(() {
          disliked = true;
        });
    });

    return Container(
      height: 500,
      width: 300,
      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onLongPress: () => showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: MovieInfo(movie: widget.movie),
                  ),
                ),
              ),
              onDoubleTap: () {
                setState(() {
                  liked = true;
                });
                movieService.onMovieLiked(widget.movie);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(widget.movie.moviePosterPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: liked
                    ? Icon(
                        FontAwesomeIcons.solidHeart,
                        color: Colors.redAccent,
                      )
                    : Icon(FontAwesomeIcons.heart),
                onPressed: () => setState(() {
                  toggleLike();
                }),
              ),
              IconButton(
                icon: disliked
                    ? Icon(
                        FontAwesomeIcons.solidThumbsDown,
                        color: Colors.blue,
                      )
                    : Icon(FontAwesomeIcons.thumbsDown),
                onPressed: () => setState(() => toggleDislike()),
              ),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_mate/src/models/genre.dart';
import 'package:movie_mate/src/models/movie.dart';
import 'package:movie_mate/src/screens/main/genre_movies_screen.dart';
import 'package:movie_mate/src/screens/main/test_genre_movies_screen.dart';
import 'package:movie_mate/src/services/genre_movies_list_service.dart';

class AllGenreTile extends StatelessWidget {
  final Genre genre;
  const AllGenreTile({Key key, this.genre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final genreMoviesListService = GenreMoviesListService(genre: genre.genre);

    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TestGenreMoviesScreen(genre: genre.genre))),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.dstATop,
              ),
              image: NetworkImage(genre.posterURL),
              fit: BoxFit.fill),
        ),
        child: Center(
          child: Text(
            genre.genre,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.amberAccent,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );

    // return StreamProvider<List<Movie>>.value(
    //   value: genreMoviesListService.movies,
    //   initialData: null,
    //   child: GestureDetector(
    //     onTap: () => Navigator.push(context,
    //         MaterialPageRoute(builder: (context) => GenreMoviesScreen())),
    //     child: Container(
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(10),
    //         image: DecorationImage(
    //             colorFilter: ColorFilter.mode(
    //               Colors.black.withOpacity(0.5),
    //               BlendMode.dstATop,
    //             ),
    //             image: NetworkImage(genre.posterURL),
    //             fit: BoxFit.fill),
    //       ),
    //       child: Center(
    //         child: Text(
    //           genre.genre,
    //           textAlign: TextAlign.center,
    //           style: TextStyle(
    //             color: Colors.amberAccent,
    //             fontSize: 24,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

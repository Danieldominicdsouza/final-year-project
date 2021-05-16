import 'package:flutter/material.dart';
import 'package:movie_mate/src/models/genre.dart';
import 'package:movie_mate/src/models/list_of_genres.dart';
import 'package:provider/provider.dart';
import 'genre_tile.dart';

class GenreListScreen extends StatelessWidget {
  const GenreListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listOfGenres = Provider.of<ListOfGenres>(context);
    final genreList = Provider.of<List<Genre>>(context);

    genreList.forEach((genre) => listOfGenres.addGenres(genre));

    List<Widget> genres = [];
    listOfGenres.listOfGenres.forEach((genre) {
      genres.add(GenreTile(
        genre: genre,
        isChecked: () => listOfGenres.updatePreference(genre),
        isPreferred: genre.isPreferred,
      ));
    });

    return ListView(children: genres);

    // return Container(
    //   padding: EdgeInsets.only(left: 20, right: 40),
    //   child: ListView.builder(
    //     itemCount: listOfGenres.length ?? 1,
    //     itemBuilder: (context, index) {
    //       return GenreTile(genre: listOfGenres[index]);
    //     },
    //   ),
    // );
  }
}

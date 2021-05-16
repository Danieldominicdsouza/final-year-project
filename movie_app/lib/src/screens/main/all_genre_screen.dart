import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_mate/src/components/all_genre/all_genre_tile.dart';
import 'package:movie_mate/src/models/genre.dart';
import 'package:provider/provider.dart';

class AllGenreScreen extends StatefulWidget {
  const AllGenreScreen({Key key}) : super(key: key);

  @override
  _AllGenreScreenState createState() => _AllGenreScreenState();
}

class _AllGenreScreenState extends State<AllGenreScreen> {
  @override
  Widget build(BuildContext context) {
    final genreList = Provider.of<List<Genre>>(context);

    // genreList.forEach((genre) {});

    return Container(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20.0,
              mainAxisSpacing: 20.0,
              childAspectRatio: 1.5),
          itemCount: genreList.length,
          itemBuilder: (context, index) {
            return AllGenreTile(genre: genreList[index]);
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movie_mate/src/models/genre.dart';

class GenreTile extends StatelessWidget {
  final Genre genre;
  final Function isChecked;
  final bool isPreferred;

  GenreTile({@required this.genre, this.isChecked, @required this.isPreferred});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: isPreferred ? Colors.grey[900] : Colors.black,
      title: Text(
        genre.genre,
        style: isPreferred
            ? TextStyle(
                color: Colors.amber,
                fontWeight: FontWeight.bold,
                //fontFamily: 'RobotoCondensed',
              )
            : TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                //fontFamily: 'RobotoCondensed',
              ),
      ),
      subtitle: Text(
        genre.description,
        style: TextStyle(fontFamily: 'RobotoCondensed'),
      ),
      trailing: Checkbox(
        onChanged: (bool isPreferred) => isChecked(),
        value: isPreferred,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LikeMoviesScreen extends StatelessWidget {
  const LikeMoviesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 0,
        itemBuilder: (context, index) {
          return LikedMovie();
        },
      ),
    );
  }
}

class LikedMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      title: Row(
        children: [
          Image(image: NetworkImage('')),
          Text('Movie Title'),
        ],
      ),
      subtitle: Text('Description'),
      trailing: Icon(FontAwesomeIcons.heart),
      onTap: () => null, //Movie Page
    );
  }
}

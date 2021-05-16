import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_mate/src/models/disliked_movie.dart';
import 'package:movie_mate/src/models/liked_movie.dart';
import 'package:movie_mate/src/services/movie_service.dart';

class MyMoviesScreen extends StatelessWidget {
  const MyMoviesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          SizedBox(height: 10),
          Container(
            height: 40,
            child: TabBar(
              //isScrollable: true,
              tabs: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Icon(FontAwesomeIcons.heart), Text('Liked')],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(FontAwesomeIcons.thumbsDown),
                    Text('Disliked')
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
              child: TabBarView(
            children: [
              StreamBuilder<List<LikedMovie>>(
                  stream: MovieService().likedMovies,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return Container(
                      child: ListView.builder(
                        itemCount: snapshot.data.length ?? 0,
                        itemBuilder: (context, index) {
                          return LikedMovieTile(
                            movieName: snapshot.data[index].movieName,
                            posterURL: snapshot.data[index].posterURL,
                          );
                        },
                      ),
                    );
                  }),
              StreamBuilder<List<DislikedMovie>>(
                  stream: MovieService().dislikedMovies,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return Container(
                      child: ListView.builder(
                        itemCount: snapshot.data.length ?? 0,
                        itemBuilder: (context, index) {
                          return disLikedMovieTile(
                            movieName: snapshot.data[index].movieName,
                            posterURL: snapshot.data[index].posterURL,
                          );
                        },
                      ),
                    );
                  }),
            ],
          )),
          // Expanded(
          //   child: Container(
          //     child: ListView.builder(
          //       itemCount: snapshot.data.length ?? 0,
          //       itemBuilder: (context, index) {
          //         return LikedMovieTile(
          //           movieName: snapshot.data[index].movieName,
          //           posterURL: snapshot.data[index].posterURL,
          //         );
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget disLikedMovieTile({String movieName, String posterURL}) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(40, 10, 20, 10),
      leading: Image(
        image: NetworkImage(posterURL ?? ''),
        fit: BoxFit.cover,
      ),
      title: Text(movieName),
      trailing: Icon(
        FontAwesomeIcons.solidThumbsDown,
        color: Colors.blue,
      ),
      onTap: () => null, //Movie Page
    );
  }
}

class LikedMovieTile extends StatelessWidget {
  final String movieName;
  final String posterURL;

  const LikedMovieTile({Key key, this.movieName, this.posterURL})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(40, 10, 20, 10),
      leading: Image(
        image: NetworkImage(posterURL ?? ''),
        fit: BoxFit.cover,
      ),
      title: Text(movieName),
      trailing: Icon(
        FontAwesomeIcons.solidHeart,
        color: Colors.redAccent,
      ),
      onTap: () => null, //Movie Page
    );
  }
}

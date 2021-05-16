import 'package:flutter/material.dart';
import 'package:movie_mate/src/models/movie.dart';

class MovieInfo extends StatelessWidget {
  final Movie movie;
  const MovieInfo({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> castList = movie.cast ?? [];
    List<String> directorList = movie.directors ?? [];
    List<String> screenplayList = movie.screenplay ?? [];
    List<Widget> castCardList = [];
    castList.forEach((actor) {
      return castCardList.add(Row(
        children: [
          CircleAvatar(),
          Text(
            actor,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ));
    });
    return Container(
      color: Colors.grey[900],
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                movie.movieName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.amberAccent,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Image.network(
                    movie.moviePosterPath,
                    fit: BoxFit.cover,
                    height: 200,
                    width: 100,
                  ),
                ),
                Container(
                  child: Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.movieDescription,
                          maxLines: 10,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('Release Date: ${movie.releaseDate}'),
                        SizedBox(height: 10),
                        Text('Language: ${movie.language}'),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Cast',
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: castCardList,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Directed by:',
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: directorList.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(),
                      Text(
                        directorList[index],
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'Screenplay by:',
                style: TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: screenplayList.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(),
                      Text(
                        screenplayList[index],
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

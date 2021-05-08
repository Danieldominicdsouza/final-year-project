import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_mate/src/components/app_drawer.dart';
import 'package:movie_mate/src/components/movie_list.dart';
import 'package:movie_mate/src/global/shared/constants.dart';
import 'package:movie_mate/src/models/movie.dart';
import 'package:movie_mate/src/models/user.dart';
import 'package:movie_mate/src/services/authentication_service.dart';
import 'package:movie_mate/src/services/database_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MyUser myUser = Provider.of<MyUser>(context);
    //final Size screenSize = MediaQuery.of(context).size;
    final _databaseService = DatabaseService();
    int _pageIndex = 0;

    final List<Widget> _pages = [
      MovieList(),
      Center(child: Text('Genre Page')),
      Center(child: Text('Liked Movies Page')),
    ];

    return StreamProvider<List<Movie>>.value(
      value: _databaseService.movies,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: appBarText,
          actions: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(myUser.username),
                SizedBox(width: 5),
                CircleAvatar(
                  backgroundColor: Colors.black,
                  backgroundImage: NetworkImage(myUser.photoURL),
                ),
              ],
            ),
          ],
        ),
        drawer: AppDrawer(
          myUser: myUser,
        ),
        body: _pages[_pageIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.grey[900],
          currentIndex: _pageIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.home,
                color: Colors.white,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.cameraRetro,
                color: Colors.grey[700],
              ),
              label: 'All Genres',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.heart,
                color: Colors.grey[700],
              ),
              label: 'Liked',
            )
          ],
        ),
      ),
    );
  }
}

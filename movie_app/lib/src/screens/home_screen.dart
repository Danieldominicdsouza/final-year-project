import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_mate/src/components/home_screen/app_drawer.dart';
import 'package:movie_mate/src/components/movie_list.dart';
import 'package:movie_mate/src/global/shared/constants.dart';
import 'package:movie_mate/src/models/movie.dart';
import 'package:movie_mate/src/models/user.dart';
import 'package:movie_mate/src/screens/chat/chat_home_screen.dart';
import 'package:movie_mate/src/screens/main/all_genre_screen.dart';
import 'package:movie_mate/src/screens/main/my_movies_screen.dart';
import 'package:movie_mate/src/services/database_service.dart';
import 'package:movie_mate/src/services/user_data_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String pageRouteId = '/home';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  int _pageIndex = 0;
  final _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    final MyUser myUser = Provider.of<MyUser>(context);
    //final Size screenSize = MediaQuery.of(context).size;
    final userDataService = UserDataService(userUid: myUser.uid);

    final List<Widget> _pages = [
      MovieList(),
      AllGenreScreen(),
      //Center(child: Text('Genre Page')),
      MyMoviesScreen(),
      ChatHome(),
      // Center(child: Text('Liked Movies Page')),
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
            StreamBuilder<MyUser>(
                stream: userDataService.updatedUsers,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(snapshot.data.username),
                        //Text(myUser.username),
                        SizedBox(width: 5),
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          backgroundImage: NetworkImage(snapshot.data.photoURL),
                        ),
                      ],
                    );
                }),
          ],
        ),
        drawer: StreamBuilder<MyUser>(
            stream: userDataService.updatedUsers,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else
                return AppDrawer(
                  myUser: snapshot.data,
                );
            }),
        body: _pages[_pageIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.grey[900],
          currentIndex: _pageIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.home,
                color: Colors.grey[700],
              ),
              activeIcon: Icon(
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
              activeIcon: Icon(
                FontAwesomeIcons.cameraRetro,
                color: Colors.white,
              ),
              label: 'All Genres',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.movie,
                color: Colors.grey[700],
              ),
              activeIcon: Icon(
                Icons.movie,
                color: Colors.white,
              ),
              label: 'My Movies',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                color: Colors.grey[700],
              ),
              activeIcon: Icon(
                Icons.chat,
                color: Colors.white,
              ),
              label: 'Chat',
            ),
          ],
          onTap: (index) {
            setState(() => _pageIndex = index);
          },
        ),
      ),
    );
  }
}

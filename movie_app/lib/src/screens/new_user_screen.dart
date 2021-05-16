import 'package:flutter/material.dart';
import 'package:movie_mate/src/components/new_user/genre_list.dart';
import 'package:movie_mate/src/models/genre.dart';
import 'package:movie_mate/src/models/list_of_genres.dart';
import 'package:movie_mate/src/models/user.dart';
import 'package:movie_mate/src/screens/home_screen.dart';
import 'package:movie_mate/src/services/genre_list_service.dart';
import 'package:movie_mate/src/services/user_data_service.dart';
import 'package:provider/provider.dart';

class NewUserScreen extends StatefulWidget {
  static const String pageRouteId = '/newUser';
  const NewUserScreen({Key key}) : super(key: key);

  @override
  _NewUserScreenState createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  @override
  Widget build(BuildContext context) {
    final myUser = Provider.of<MyUser>(context);
    final userDataService = UserDataService(userUid: myUser.uid);
    return SafeArea(
      child: MultiProvider(
        providers: [
          // StreamProvider<List<Genre>>(
          //   create: (_) => GenreListService().genres,
          //   initialData: [],
          // ),
          ChangeNotifierProvider<ListOfGenres>(create: (_) => ListOfGenres()),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Container(
              padding: EdgeInsets.only(left: 20),
              child: StreamBuilder<MyUser>(
                  stream: userDataService.updatedUsers,
                  builder: (context, snapshot) {
                    return Text(
                      'Welcome to MovieMate ${snapshot.data.username}',
                      style: TextStyle(
                        color: Colors.amber,
                        fontFamily: 'RobotoCondensed',
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 40, left: 35, bottom: 40),
                child: Text(
                  'Pick your favourite Genres',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 40),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: GenreListScreen(),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await UserDataService(userUid: myUser.uid)
                  .updateUserGenrePreference(ListOfGenres.selectedGenres);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Icon(Icons.check),
          ),
        ),
      ),
    );
  }
}

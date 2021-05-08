import 'package:flutter/material.dart';
import 'package:movie_mate/src/components/media_card.dart';
import 'package:movie_mate/src/services/authentication_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> cardList = [];

  @override
  void initState() {
    super.initState();
    cardList = _getMediaCard();
  }

  void removeCard(int index) {
    setState(() {
      cardList.removeAt(index);
    });
  }

  List<Widget> _getMediaCard() {
    String _posterName1 = 'assets/movies/focus.jpg';
    String _posterName2 = 'assets/movies/avengers_infinity_war.jpg';
    String _posterName3 = 'assets/movies/mib.jpg';

    List<MediaCard> cards = [];
    cards.add(MediaCard(poster: _posterName1, position: 10));
    cards.add(MediaCard(poster: _posterName2, position: 20));
    cards.add(MediaCard(poster: _posterName3, position: 30));

    List<Widget> cardList = [];

    for (var i = 0; i < 3; i++) {
      cardList.add(
        Draggable(
          onDragEnd: (drag) {
            removeCard(i);
          },
          feedback: Card(
            color: Color.fromARGB(0, 0, 0, 0),
            child: Image(
              image: AssetImage(cards[i]
                  .poster), //you have to add .poster because it's a list of MediaCard not String
              // width: 500,
              // height: 300,
            ),
          ),
          child: Card(
            color: Color.fromARGB(0, 0, 0, 0),
            child: Container(
              height: 500,
              width: 300,
              child: Image(
                image: AssetImage(cards[i].poster),
              ),
            ),
          ),
        ),
      );
    }

    return cardList;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final _authService = AuthService();

    return SafeArea(
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.logout),
                  color: Color.fromARGB(255, 203, 155, 81), //Hex CB9B51
                  //color: Colors.amber,
                  onPressed: () {
                    _authService.signOut();
                  },
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'MovieMate',
                    style: TextStyle(
                      color: Colors.amber,
                      fontFamily: 'RobotoCondensed',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  //*Will be dynamic
                  'Username',
                  style: TextStyle(
                      fontFamily: 'RobotoCondensed',
                      color: Colors.amber,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1.0, 1.5),
                          color: Color.fromARGB(80, 255, 255, 255),
                          blurRadius: 1,
                        ),
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey[800],
                ),
              ),
              //*Ideally we'll put the user avatar/custom image here/google profile image here
              // IconButton(
              //   onPressed: () {},
              //   icon: Icon(Icons.person),
              //   color: Colors.amber,
              // ),
            ],
          ),
          body: Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: screenSize.width,
                  height: screenSize.height,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Stack(
                          children: cardList,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.clear_rounded),
                              onPressed: () {},
                              color: Colors.redAccent,
                            ),
                            //!This sized box will be dynamic on the width of the image gotten from the media query/screen size
                            SizedBox(
                              width: 50,
                            ),
                            IconButton(
                                icon: Icon(Icons.check_circle_outline_rounded),
                                color: Colors.greenAccent,
                                onPressed: () {}),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

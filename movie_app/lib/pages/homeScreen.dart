import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: Icon(Icons.menu_rounded),
              //color: Color.fromARGB(255, 203, 155, 81), //Hex CB9B51
              color: Colors.redAccent,
              onPressed: () {},
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  //*Will be dynamic
                  'Username',
                  style: TextStyle(
                      fontFamily: 'RobotoCondensed',
                      color: Colors.redAccent,
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
                  width: size.width,
                  height: size.height,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Card(
                          color: Color.fromARGB(0, 0, 0, 0),
                          child: Image(
                            image:
                                AssetImage('movies/avengers_infinity_war.jpg'),
                            // width: 500,
                            // height: 300,
                          ),
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

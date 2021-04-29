import 'package:flutter/material.dart';
import 'package:movie_mate/src/global/shared/constants.dart';
import 'package:movie_mate/src/models/user.dart';
import 'package:movie_mate/src/services/authenticaitonService.dart';
import 'dart:math';

import 'package:movie_mate/src/widgets/auth_custom_widgets.dart';
import 'package:provider/provider.dart';

class TestHomeScreen extends StatelessWidget {
  final _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: appBarText,
        actions: [
          Row(
            children: [
              Text('username'),
              SizedBox(width: 5),
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  _authService.signOut();
                },
              ),
            ],
          )
        ],
      ),
      body: TestHome(),
    );
  }
}

class TestHome extends StatefulWidget {
  @override
  _TestHomeState createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {
  //TODO: Move it to custom widgets
  Widget _preferenceButton(String buttonText, IconData iconData, Color color) {
    return GestureDetector(
      onTap: () async {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('You have ${buttonText}d this movie')));

        await Future.delayed(Duration(milliseconds: 800));
        ScaffoldMessenger.of(context).removeCurrentSnackBar();

        setState(() {
          _movieNumber = Random().nextInt(4) + 1;
        });
      },
      child: Container(
        height: 45.0,
        width: 100.0,
        //color: Colors.amber, //Adding this causes error because it conflicts with box decoration
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              iconData,
              color: color,
            ),
            //Adding an Icon Button overrides the functionality of GestureDetector and does nothing if onPressed is Empty
            Text(
              buttonText,
              style: TextStyle(color: color),
            ),
          ],
        ),
      ),
    );
  }

  int _movieNumber = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Center(
          child: Image.asset(
            'assets/movies/movie$_movieNumber.jpg',
            height: 400.0,
            width: 400.0,
          ),
        ),
        SizedBox(
          height: 45,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _preferenceButton('Dislike', Icons.clear, Colors.redAccent),
            _preferenceButton('Like', Icons.check, Colors.green),
          ],
        )
      ],
    );
  }
}

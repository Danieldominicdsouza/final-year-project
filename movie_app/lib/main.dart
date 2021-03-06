import 'package:flutter/material.dart';
//import 'HomePage.dart';

void main() {
  runApp(MyMovie());
}

class MyMovie extends StatefulWidget {
  @override
  _MyMovieState createState() => _MyMovieState();
}

class _MyMovieState extends State<MyMovie> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Welcome to Movie Magic"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Stack(
                  //fit: StackFit.expand,
                  children: <Widget>[
                    //AssetImage('ticket2.png'),
                    Container(
                      child: Image.asset('images/ticket2.png',
                          width: 390.62, height: 209.0),
                    ),

                    Column(
                      children: [
                        Container(
                          height: 20.0,
                        ),
                        Container(
                          width: 300.0,
                          height: 25.0,
                          child: Text(
                            'Email',
                            style: TextStyle(fontSize: 15.0),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          width: 300.0,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),

                              //hintText: 'Enter valid email id as abc@gmail.com'
                            ),
                          ),
                        ),
                        Container(height: 10.0),
                        Container(
                          width: 300.0,
                          height: 25.0,
                          child: Text(
                            'Password',
                            style: TextStyle(fontSize: 15.0),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          width: 300.0,

                          //padding: const EdgeInsets.only(
                          // left: 15.0, right: 15.0, top: 15, bottom: 0),
                          //padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.amber),
                              border: OutlineInputBorder(),

                              //hintText: 'Enter secure password'
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,

                    //color: Colors.white,
                    child: Image.asset('images/ticket2.png',
                        width: 56.18, height: 105.0),
                  ),
                  Container(
                      alignment: Alignment.center,
                      height: 100.0,
                      child: FlatButton(
                        splashColor: Colors.red,
                        onPressed: () {
                          print('Homepage here');

                          //HOMEPAGE WILL BE HERE!!!
                          //Navigator.push(
                            //  context, MaterialPageRoute(builder: (_) => HomePage()));
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ),),

                ],
              ),
              //Container(
              //child: Image.asset('images/ticket2.png',
              //   width: 56.18, height: 105.0),
              //),
              Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have an account?",
                      //textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    FlatButton(
                     // focusColor: Colors.black,
                      splashColor: Colors.red,
                      //hoverColor: Colors.red,
                      //highlightColor: Colors.indigo,



                      onPressed: () {
                        //SIGN UP PAGE HERE!!!
                        print('signup page here');
                      },
                      child: Text(
                        'Click Here',
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 25.0,
                padding: EdgeInsets.only(bottom: 5.0),
                child: Text("OR",
                style: TextStyle(color: Colors.amber,
                fontWeight: FontWeight.bold,
                fontSize: 15.0),),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.black, borderRadius: BorderRadius.circular(20)),
                child: RaisedButton.icon(

                  color: Colors.white,
                  splashColor: Colors.grey,
                  onPressed: () {
                    print('google login page here');

                  },
                  label: Text(
                    'Sign In With Google',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  icon: Icon(Icons.android, color: Colors.green,) ,


                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

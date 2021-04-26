import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:movie_mate/src/services/authenticaitonService.dart';
import 'package:movie_mate/src/shared/textFields.dart';

class LoginScreen extends StatefulWidget {
  final Function toggleView;
  LoginScreen({this.toggleView});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String email = '', password = '', error = '';

  void onListen() => setState(() {});

  @override
  void initState() {
    super.initState();
    emailController.addListener(onListen);
    passwordController.addListener(onListen);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailController.removeListener(onListen);
    passwordController.removeListener(onListen);
    super.dispose();
  }

  Widget _EmailTextField() {
    return TextFormField(
      controller: emailController,
      validator: (userEmail) => _authService.EmailValidation(userEmail),
      onChanged: (userEmail) => setState(() => email = userEmail.trim()),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        suffixIcon: emailController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: Icon(Icons.close),
                onPressed: () => emailController.clear(),
              ),
        hintText: 'Enter your Email',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(50),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        labelText: 'Email',
        labelStyle: TextStyle(
          color: Colors.grey[800],
        ),
        isDense: true, // Added this
        contentPadding: EdgeInsets.all(0), // Added this
      ),
      keyboardType: TextInputType.emailAddress,
      autofillHints: [AutofillHints.email],
    );
  }

  Widget _PasswordTextField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      validator: (userPassword) =>
          _authService.PasswordValidation(userPassword),
      // validator: (userPassword) => userPassword
      //             .length >
      //         6
      //     ? null
      //     : 'Enter a password longer than 6 chars',
      onChanged: (userPassword) =>
          setState(() => password = userPassword.trim()),
      decoration: InputDecoration(
        hintText: 'Enter a secure password',
        prefixIcon: Icon(
          Icons.lock,
        ),
        suffixIcon: passwordController.text.isEmpty
            ? Container(width: 0)
            : IconButton(
                icon: Icon(Icons.close),
                onPressed: () => passwordController.clear(),
              ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(50),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        labelText: 'Password',
        labelStyle: TextStyle(color: Colors.grey[800]),
        isDense: true,
        contentPadding: EdgeInsets.all(0),
      ),
    );
  }

  _LoginButton() {
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Image.asset('assets/images/ticket.png',
              width: 56.18, height: 105.0),
        ),
        Container(
          alignment: Alignment.center,
          height: 100.0,
          child: TextButton(
            //splashColor: Colors.red,
            onPressed: () {
              _authService.signInWithEmailAndPassword(email, password);
            },
            child: Text(
              'Login',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: Text(
            "MovieMate",
            style: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.amber,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 1.5),
                    color: Colors.black, //Color.fromARGB(80, 255, 255, 255),
                    blurRadius: 1,
                  ),
                ]),
          ),
          actions: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Register →',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[600],
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.person_outline),
                  color: Colors.amber,
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: screenSize.height - 400,
                  width: screenSize.width - 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(colors: [
                        //Color(0xFF462523), //1
                        Color(0xFF512F27), //2
                        Color(0xFF6C4730), //3
                        Color(0xFF956B3E), //4
                        Color(0xFFBC8E4C),
                        Color(0xFFCA9A51), //5
                        Color(0xFFE2C167), //6
                        Color(0xFFEDD372), //7
                        Color(0xFFF0D874), //8
                        Color(0xFFF6E27A), //9
                        Color(0xFFF6E68C),
                        Color(0xFFF6E589), //10
                        Color(0xFFF6EEAF),
                        Color(0xFFF6F2C0), //11
                        Color(0xFFF6EEAF),
                        Color(0xFFF6E589), //10
                        Color(0xFFF6E68C),
                        Color(0xFFF6E27A), //9
                        Color(0xFFF0D874), //8
                        Color(0xFFEDD372), //7
                        Color(0xFFE2C167), //6
                        Color(0xFFCA9A51), //5
                        Color(0xFFBC8E4C),
                        Color(0xFF956B3E), //4
                        Color(0xFF6C4730), //3
                        Color(0xFF512F27), //2
                        //Color(0xFF462523), //1
                      ])),
                  child: Stack(
                    //fit: StackFit.expand,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Welcome Back",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'RobotoCondensed',
                                    fontWeight: FontWeight.bold,
                                    // shadows: <Shadow>[
                                    //   Shadow(
                                    //     offset: Offset(1.0, 1.5),
                                    //     color:
                                    //         Color.fromARGB(80, 255, 255, 255),
                                    //     blurRadius: 1,
                                    //   ),
                                    // ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                _EmailTextField(),
                                SizedBox(height: 30),
                                _PasswordTextField(),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                _LoginButton(),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Colors.white,
                          //fontFamily: 'RobotoCondensed',
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        //splashColor: Colors.white,
                        onPressed: () {
                          print('Switched to Register Page');
                          widget.toggleView();
                        },
                        child: Text(
                          'Click Here',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.amber, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 25.0,
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    "OR",
                    style: TextStyle(
                        color: Colors.amber,
                        fontFamily: 'RobotoCondensed',
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                    onPressed: () {
                      print('google login page here');
                    },
                    label: Text(
                      'Sign In With Google',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'RobotoCondensed',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    icon: Icon(
                      Icons.android,
                      color: Colors.green,
                    ),
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

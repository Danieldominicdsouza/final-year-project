import 'package:flutter/material.dart';
import 'package:movie_mate/src/services/authenticaitonService.dart';

class RegisterScreen extends StatefulWidget {
  final Function toggleView;
  RegisterScreen({this.toggleView});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String email = "", password = "", error = "";

  void onListen() => setState(() {});

  Future<void> _registerUser(String email, String password) async {
    if (_formKey.currentState.validate()) {
      dynamic result =
          _authService.registerWithEmailAndPassword(email, password);
      if (result == null) {
        setState(() {
          error = 'Please enter valid inputs';
        });
      } else
        print('Registeration success');
    }
  }

  Widget _emailTextField() {
    return TextFormField(
      controller: emailController,
      validator: (userEmail) => _authService.emailValidation(userEmail),
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

  Widget _passwordTextField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      validator: (userPassword) =>
          _authService.passwordValidation(userPassword),
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

  _signUpButton() {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: Image.asset('assets/images/ticket.png',
              width: 56.18, height: 105.0),
        ),
        Container(
          alignment: Alignment.center,
          height: 100.0,
          child: TextButton(
            onPressed: () => _registerUser(email, password).then(
                (_) => Navigator.pushReplacementNamed(context, '/verify')),
            child: Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

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
                color: Colors.amber,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.w600,
                shadows: <Shadow>[
                  Shadow(
                    offset: Offset(1.0, 1.5),
                    color: Colors.black, // Color.fromARGB(80, 255, 255, 255),
                    blurRadius: 1,
                  ),
                ]),
          ),
          actions: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Sign In →',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[600],
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.w600,
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Stack(
                    //fit: StackFit.expand,
                    children: <Widget>[
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
                          ]),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Welcome to MovieMate",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'RobotoCondensed',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  _emailTextField(),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  _passwordTextField(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _signUpButton(),
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          print('signup page here');
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
                  // height: 50,
                  // width: 250,
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

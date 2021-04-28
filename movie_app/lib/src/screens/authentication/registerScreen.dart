import 'package:flutter/material.dart';
import 'package:movie_mate/src/services/authenticaitonService.dart';
import 'package:movie_mate/src/widgets/auth_custom_widgets.dart';

class RegisterScreen extends StatefulWidget {
  final Function toggleView;
  RegisterScreen({this.toggleView});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String email = "", password = "", error = "", username = "";

  void onListen() => setState(() {});

  Future<void> _registerUser(
      String email, String password, String username) async {
    if (_formKey.currentState.validate()) {
      dynamic result =
          _authService.registerWithEmailAndPassword(email, password, username);
      if (result == null) {
        setState(() {
          error = 'Please enter valid inputs';
        });
      } else
        print('Registeration success');
    }
  }

  Widget _usernameTextField() {
    return TextFormField(
      controller: _usernameController,
      validator: (username) => username.isNotEmpty && username.length > 4
        ? null
        : 'Enter a valid Username',//_authService.usernameValidation(username),
      onChanged: (username) => setState(() => username = username.trim()),
      decoration: textInputDecoration(
              'Username', 'Enter an username', _usernameController)
          .copyWith(prefixIcon: Icon(Icons.person_sharp)),
      keyboardType: TextInputType.emailAddress,
      autofillHints: [AutofillHints.email],
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      controller: _emailController,
      validator: (userEmail) => _authService.emailValidation(userEmail),
      onChanged: (userEmail) => setState(() => email = userEmail.trim()),
      decoration:
          textInputDecoration('Email', 'Enter an Email', _emailController)
              .copyWith(prefixIcon: Icon(Icons.email)),
      keyboardType: TextInputType.emailAddress,
      autofillHints: [AutofillHints.email],
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      validator: (userPassword) =>
          _authService.passwordValidation(userPassword),
      onChanged: (userPassword) =>
          setState(() => password = userPassword.trim()),
      decoration: textInputDecoration(
              'Password', 'Enter a password', _passwordController)
          .copyWith(prefixIcon: Icon(Icons.lock)),
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
            onPressed: () => _registerUser(email, password, username)
            .then(
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
    _emailController.addListener(onListen);
    _passwordController.addListener(onListen);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailController.removeListener(onListen);
    _passwordController.removeListener(onListen);
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
          title: appBarAppText(),
          actions: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Register',
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
                    print('Switched to Login Screen');
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
                        decoration: goldenContainerBoxDecoration(),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    goldenContainerText('Welcome to MovieMate'),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    _usernameTextField(),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    _emailTextField(),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    _passwordTextField(),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          widget.toggleView();
                          print('Switched to Login Screen');
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
                googleSignInButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

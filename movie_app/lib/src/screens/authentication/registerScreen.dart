import 'package:flutter/material.dart';
import 'package:movie_mate/src/global/shared/constants.dart';
import 'package:movie_mate/src/services/authValidation_bloc.dart';
import 'package:movie_mate/src/services/authenticationService.dart';
import 'package:movie_mate/src/widgets/auth_custom_widgets.dart';
import 'package:provider/provider.dart';

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
  String email = '', password = '', username = '';

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(onListen);
    _emailController.addListener(onListen);
    _passwordController.addListener(onListen);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.removeListener(onListen);
    _emailController.removeListener(onListen);
    _passwordController.removeListener(onListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final validationBloc = Provider.of<AuthValidationBloc>(context);
    final Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: appBarText,
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Container(
                height: screenSize.height - 350,
                width: screenSize.width - 60,
                decoration: goldenContainerBoxDecoration(),
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          goldenContainerText('Welcome to MovieMate'),
                          SizedBox(height: 25.0),
                          _usernameTextField(validationBloc),
                          SizedBox(height: 25.0),
                          _emailTextField(validationBloc),
                          SizedBox(height: 25.0),
                          _passwordTextField(validationBloc),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              _signUpButton(validationBloc),
              Column(
                children: [
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
                                color: Colors.amber,
                                fontWeight: FontWeight.bold),
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
                          color: Colors.white,
                          fontFamily: 'RobotoCondensed',
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                    ),
                  ),
                ],
              ),
              googleSignInButton(),
            ],
          ),
        ),
      ),
    );
  }

  void onListen() => setState(() {});

  Future<void> _registerUser(
      String email, String password, String username) async {
    if (_formKey.currentState.validate()) {
      dynamic result = await _authService.registerWithEmailAndPassword(
          email, password, username);
      if (result == null) {
        print('Email in use');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Email already in use')));
      } else {
        print('Registration success');
      }
    }
  }

  Widget _usernameTextField(AuthValidationBloc validationBloc) {
    return StreamBuilder<String>(
        stream: validationBloc.username,
        builder: (context, snapshot) {
          return TextFormField(
            controller: _usernameController,
            onChanged: validationBloc.changeUsername,
            decoration: textInputDecoration(
                    'Username', 'Enter an username', _usernameController)
                .copyWith(
                    errorText: snapshot.error,
                    prefixIcon: Icon(Icons.person_sharp)),
            keyboardType: TextInputType.emailAddress,
            autofillHints: [AutofillHints.email],
          );
        });
  }

  Widget _emailTextField(AuthValidationBloc validationBloc) {
    return StreamBuilder<String>(
        stream: validationBloc.email,
        builder: (context, snapshot) {
          return TextFormField(
            controller: _emailController,
            onChanged: validationBloc.changeEmail,
            decoration:
                textInputDecoration('Email', 'Enter an Email', _emailController)
                    .copyWith(
                        errorText: snapshot.error,
                        prefixIcon: Icon(Icons.email)),
            keyboardType: TextInputType.emailAddress,
            autofillHints: [AutofillHints.email],
          );
        });
  }

  Widget _passwordTextField(AuthValidationBloc validationBloc) {
    return StreamBuilder<String>(
        stream: validationBloc.password,
        builder: (context, snapshot) {
          return TextFormField(
            controller: _passwordController,
            obscureText: true,
            onChanged: validationBloc.changePassword,
            decoration: textInputDecoration(
                    'Password', 'Enter a password', _passwordController)
                .copyWith(
              errorText: snapshot.error,
              prefixIcon: Icon(Icons.lock),
            ),
          );
        });
  }

  Widget _signUpButton(AuthValidationBloc validationBloc) {
    username = _usernameController.text.trim();
    email = _emailController.text.trim();
    password = _passwordController.text.trim();
    return StreamBuilder<bool>(
        stream: validationBloc.validRegistration,
        builder: (context, snapshot) {
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
                  onPressed: !snapshot.hasData
                      ? null
                      : () => _registerUser(email, password, username),
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
        });
  }
}

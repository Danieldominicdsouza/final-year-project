import 'package:flutter/material.dart';
import 'package:movie_mate/src/global/shared/constants.dart';
import 'package:movie_mate/src/services/authValidation_bloc.dart';
import 'package:movie_mate/src/services/authenticaitonService.dart';
import 'package:movie_mate/src/widgets/auth_custom_widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final Function toggleView;
  LoginScreen({this.toggleView});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String email = '', password = '';

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
                Text(
                  'Sign In',
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
                    print('Switched to Register Screen');
                    widget.toggleView();
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
                height: screenSize.height - 400,
                width: screenSize.width - 60,
                decoration: goldenContainerBoxDecoration(),
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        goldenContainerText('Welcome Back'),
                        SizedBox(height: 20),
                        _emailTextField(validationBloc),
                        SizedBox(height: 30),
                        _passwordTextField(validationBloc),
                      ],
                    ),
                  ),
                ),
              ),
              _loginButton(validationBloc),
              Column(
                children: [
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
                            print('Switched to Register Screen');
                            widget.toggleView();
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

  Widget _emailTextField(AuthValidationBloc validaitonBloc) {
    return StreamBuilder<String>(
        stream: validaitonBloc.email,
        builder: (context, snapshot) {
          return TextFormField(
            controller: _emailController,
            onChanged: validaitonBloc.changeEmail,
            decoration:
                textInputDecoration('Email', 'Enter an Email', _emailController)
                    .copyWith(
              errorText: snapshot.error,
              prefixIcon: Icon(Icons.email),
            ),
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

  _loginButton(AuthValidationBloc validationBloc) {
    email = _emailController.text.trim();
    password = _passwordController.text.trim();
    return StreamBuilder<bool>(
        stream: validationBloc.validLogin,
        builder: (context, snapshot) {
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
                  onPressed: !snapshot.hasData
                      ? null
                      : () async => await _authService
                          .signInWithEmailAndPassword(email, password),
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
        });
  }
}

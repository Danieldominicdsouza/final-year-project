import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:movie_mate/src/global/shared/constants.dart';
import 'package:movie_mate/src/blocs/auth_validation_bloc.dart';
import 'package:movie_mate/src/services/authentication_service.dart';
import 'package:movie_mate/src/widgets/auth_custom_widgets.dart';
import 'package:movie_mate/src/widgets/email_password_widget.dart';
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
  AuthValidationBloc validationBloc;
  String email = '', password = '';
  bool showLoading = false;

  void onListen() => setState(() {});

  @override
  void initState() {
    _emailController.addListener(onListen);
    _passwordController.addListener(onListen);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailController.removeListener(onListen);
    _passwordController.removeListener(onListen);
    validationBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    validationBloc = Provider.of<AuthValidationBloc>(context);
    final Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: appBarText,
          actions: [
            AuthPageToggle(
              pageIdentity: 'Sign In',
              toggleView: widget.toggleView,
            ),
          ],
        ),
        body: ModalProgressHUD(
          inAsyncCall: showLoading,
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
                  decoration: goldenContainerBoxDecoration(),
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          goldenContainerText('Welcome Back')
                              .textWidget('Welcome Back'),
                          SizedBox(height: 20),
                          EmailPassword(
                            emailController: _emailController,
                            passwordController: _passwordController,
                          ),
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
      ),
    );
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
                      : () async {
                          setState(() {
                            showLoading = true;
                          });
                          try {
                            final dynamic result = await _authService
                                .signInWithEmailAndPassword(email, password);
                            if (result is String) {
                              setState(() {
                                showLoading = false;
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(result)));
                              });
                            }
                          } catch (e) {
                            setState(() {
                              showLoading = false;
                              print(e.toString());
                            });
                          }
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
        });
  }
}

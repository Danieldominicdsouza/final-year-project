import 'package:flutter/material.dart';
import 'package:movie_mate/src/blocs/auth_validation_bloc.dart';
import 'package:provider/provider.dart';

import 'auth_custom_widgets.dart';

class EmailPassword extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const EmailPassword({this.emailController, this.passwordController});

  @override
  Widget build(BuildContext context) {
    final AuthValidationBloc validationBloc =
        Provider.of<AuthValidationBloc>(context);
    return Column(
      children: [
        StreamBuilder<String>(
            stream: validationBloc.email,
            builder: (context, snapshot) {
              return TextFormField(
                controller: emailController,
                onChanged: validationBloc.changeEmail,
                decoration: textInputDecoration(
                        'Email', 'Enter an Email', emailController)
                    .copyWith(
                  errorText: snapshot.error,
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                autofillHints: [AutofillHints.email],
              );
            }),
        SizedBox(height: 30),
        StreamBuilder<String>(
            stream: validationBloc.password,
            builder: (context, snapshot) {
              return TextFormField(
                controller: passwordController,
                obscureText: true,
                onChanged: validationBloc.changePassword,
                decoration: textInputDecoration(
                        'Password', 'Enter a password', passwordController)
                    .copyWith(
                  errorText: snapshot.error,
                  prefixIcon: Icon(Icons.lock),
                ),
              );
            }),
      ],
    );
  }
}

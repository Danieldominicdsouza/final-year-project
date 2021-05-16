import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:movie_mate/src/blocs/google_signin_bloc.dart';

TextFormField textFormField(
    TextEditingController controller, String labelText, String hintText) {
  return TextFormField(
    controller: controller,
    // onChanged: validationBloc.changeEmail,
    decoration: textInputDecoration(labelText, hintText, controller),
    // keyboardType: TextInputType.emailAddress,
    // autofillHints: [AutofillHints.email],
  );
}

InputDecoration textInputDecoration(
    String labelText, String hintText, TextEditingController controller) {
  return InputDecoration(
    //prefixIcon: Icon(Icons.email),
    suffixIcon: controller.text.isEmpty
        ? Container(width: 0)
        : IconButton(
            icon: Icon(Icons.close),
            onPressed: () => controller.clear(),
          ),
    hintText: hintText,
    // focusedBorder: OutlineInputBorder(
    //   borderSide: BorderSide(color: Colors.blueGrey),
    //   borderRadius: BorderRadius.circular(50),
    // ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
    ),
    labelText: labelText,
    labelStyle: TextStyle(
      color: Colors.grey[800],
    ),
    isDense: true, // Added this
    contentPadding: EdgeInsets.all(0), // Added this
  );
}

BoxDecoration goldenContainerBoxDecoration() {
  return BoxDecoration(
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
  );
}

TypewriterAnimatedText goldenContainerText(String text) {
  return TypewriterAnimatedText(text,
      textStyle: TextStyle(
        fontSize: 20,
        fontFamily: 'RobotoCondensed',
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      textAlign: TextAlign.center);
}

Widget googleSignInButton() {
  return Container(
    decoration: BoxDecoration(
        color: Colors.black, borderRadius: BorderRadius.circular(20)),
    child: ElevatedButton.icon(
      style: ElevatedButton.styleFrom(primary: Colors.white),
      onPressed: () {
        GoogleSignInBloc().signInWithGoogle();
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
  );
}

class AuthPageToggle extends StatelessWidget {
  final String pageIdentity;
  final Function toggleView;

  const AuthPageToggle({this.pageIdentity, this.toggleView});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          pageIdentity,
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
            print('Switched from $pageIdentity Screen');
            toggleView();
          },
        )
      ],
    );
  }
}

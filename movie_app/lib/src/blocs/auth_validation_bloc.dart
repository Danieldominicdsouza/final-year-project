import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:rxdart/rxdart.dart';

class AuthValidationBloc {
  final _username = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  //Get
  Stream<String> get username => _username.stream.transform(validateUsername);
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get validLogin =>
      Rx.combineLatest2(email, password, (email, password) => true);
  Stream<bool> get validRegistration => Rx.combineLatest3(
      username, email, password, (username, email, password) => true);

  //Set
  Function(String) get changeUsername => _username.sink.add;
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  void dispose() {
    _username.close();
    _email.close();
    _password.close();
  }

  //Transformers
  final validateUsername = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
    if (username.length >= 4) {
      sink.add(username);
    } else {
      sink.addError('Enter a username longer than 3 chars');
    }
  });

  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email != null && EmailValidator.validate(email)) {
      sink.add(email);
    } else {
      sink.addError('Enter a valid email');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 6) {
      sink.add(password);
    } else {
      sink.addError('Enter a password longer than 6 chars');
    }
  });
}

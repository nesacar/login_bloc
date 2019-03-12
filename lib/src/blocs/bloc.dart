import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'validators.dart';

class Bloc extends Object with Validators {
  // final _email = StreamController<String>.broadcast();
  // final _password = StreamController<String>.broadcast();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get submitValid =>
      Observable.combineLatest2(email, password, (e, p) => true);

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  submit(){
    final emailValue =_email.value;
    final passwordValue =_password.value;

    print('email is: $emailValue and password is $passwordValue');
  }

  dispose() {
    _email.close();
    _password.close();
  }
}

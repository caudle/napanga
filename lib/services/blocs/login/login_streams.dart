import 'dart:async';

import 'package:rxdart/rxdart.dart';

class LoginStream {
  //stream controllers
  PublishSubject<String> _emailController = PublishSubject<String>();
  PublishSubject<String> _passwordController = PublishSubject<String>();

  //streams
  Stream<String> get emailStream =>
      _emailController.stream.transform(emailValidator());

  Stream<String> get passwordStream =>
      _passwordController.stream.transform(passwordValidator());

  Stream<bool> get login =>
      CombineLatestStream.combine2(emailStream, passwordStream, (a, b) => true);

  //sinks
  Function(String) get emailSink => _emailController.sink.add;
  Function(String) get passwordSink => _passwordController.sink.add;

  //validators
  StreamTransformer<String, String> emailValidator() {
    return StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink) {
        if (email.contains('@')) {
          sink.add(email);
        } else {
          sink.addError('invalid email address');
        }
      },
    );
  }

  StreamTransformer<String, String> passwordValidator() {
    return StreamTransformer<String, String>.fromHandlers(
        handleData: (password, sink) {
      if (password.length > 5)
        sink.add(password);
      else
        sink.addError('Invalid password');
    });
  }

  //dispose controllers
  void dispose() {
    _emailController.close();
    _passwordController.close();
  }
}

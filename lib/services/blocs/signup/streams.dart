import 'dart:async';

import 'package:rxdart/rxdart.dart';

class AuthStream {
  //stream controllers
  PublishSubject<String> _nameController = PublishSubject<String>();

  PublishSubject<String> _phoneController = PublishSubject<String>();

  PublishSubject<String> _emailController = PublishSubject<String>();

  PublishSubject<String> _usernameController = PublishSubject<String>();

  PublishSubject<String> _password1Controller = PublishSubject<String>();

  PublishSubject<String> _password2Controller = PublishSubject<String>();

  //streams
  Stream<String> get nameStream =>
      _nameController.stream.transform(nameValidator());

  Stream<String> get phoneStream =>
      _phoneController.stream.transform(phoneValidator());

  Stream<String> get emailStream =>
      _emailController.stream.transform(emailValidator());

  Stream<String> get usernameStream =>
      _usernameController.stream.transform(usernameValidator());

  Stream<String> get password1Stream =>
      _password1Controller.stream.transform(password1Validator());

  Stream<String> get password2Stream =>
      _password2Controller.stream.transform(password2Validator());

  Stream<bool> get continueStream => CombineLatestStream.combine3(
      nameStream, phoneStream, emailStream, (a, b, c) => true);

  Stream<bool> get signupStream => CombineLatestStream.combine3(
      usernameStream, password1Stream, password2Stream, (a, b, c) => true);
  //sinks
  Function(String) get nameSink => _nameController.sink.add;

  Function(String) get phoneSink => _phoneController.sink.add;

  Function(String) get emailSink => _emailController.sink.add;

  Function(String) get usernameSink => _usernameController.sink.add;

  Function(String) get password1Sink => _password1Controller.sink.add;

  Function(String) get password2Sink => _password2Controller.sink.add;

  // stream validators
  StreamTransformer<String, String> nameValidator() {
    return StreamTransformer<String, String>.fromHandlers(
      handleData: (name, sink) {
        if (name.length > 0) {
          sink.add(name);
        } else {
          sink.addError('enter Full name');
        }
      },
    );
  }

  StreamTransformer<String, String> emailValidator() {
    return StreamTransformer<String, String>.fromHandlers(
      handleData: (email, sink) {
        if (email.contains('@')) {
          sink.add(email);
        } else {
          sink.addError('enter a valid email address');
        }
      },
    );
  }

  StreamTransformer<String, String> password1Validator() {
    return StreamTransformer<String, String>.fromHandlers(
        handleData: (password, sink) {
      if (password.length > 5)
        sink.add(password);
      else
        sink.addError('minimum characters is 6');
    });
  }

  StreamTransformer<String, String> password2Validator() {
    String pass1;
    password1Stream.listen((value) {
      pass1 = value;
    }, onError: (_) {});
    return StreamTransformer<String, String>.fromHandlers(
        handleData: (password2, sink) {
      if (password2 == pass1)
        sink.add(password2);
      else
        sink.addError('password do not match');
    });
  }

  StreamTransformer<String, String> phoneValidator() {
    return StreamTransformer<String, String>.fromHandlers(
      handleData: (phone, sink) {
        if (phone.startsWith('0') && phone.length == 10) {
          sink.add(phone);
        } else {
          sink.addError('enter a valid phone number');
        }
      },
    );
  }

  StreamTransformer<String, String> usernameValidator() {
    return StreamTransformer<String, String>.fromHandlers(
        handleData: (username, sink) {
      if (username.length > 0)
        sink.add(username);
      else
        sink.addError('enter username');
    });
  }

  void dispose() {
    _nameController.close();

    _phoneController.close();

    _emailController.close();

    _usernameController.close();

    _password1Controller.close();

    _password2Controller.close();
  }
}

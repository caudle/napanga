import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:napanga/models/user.dart';
import 'package:napanga/services/auth.dart';
import 'package:napanga/services/blocs/login/login_streams.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this.loginStream) : super(LoginInitial());

  final LoginStream loginStream;
  final AuthService _authService = AuthService();
  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButton) {
      yield LoadingState();
      UserModel userModel =
          UserModel(email: emailValue, password: passwordValue);
      var result = await _loginWithEmailAndPassword(userModel);
      yield result is UserModel
          ? SuccessState()
          : FailureState(errorMessage: result);
    }
  }

  //log in user
  Future _loginWithEmailAndPassword(UserModel userModel) async {
    //log in user
    try {
      return await _authService.signInWithEmailAndPassword(userModel);
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  //streams and sinks
  Stream<String> get email => loginStream.emailStream;
  Stream<String> get password => loginStream.passwordStream;
  Stream<bool> get login => loginStream.login;
  Function(String) get emailSink => loginStream.emailSink;
  Function(String) get passwordSink => loginStream.passwordSink;

  //values
  String emailValue;
  String passwordValue;
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:napanga/models/user.dart';
import 'package:napanga/services/auth.dart';
import 'package:napanga/services/blocs/signup/streams.dart';
import 'package:napanga/services/repository.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc(this.authStream) : super(SignupInitial());

  final AuthStream authStream;
  final AuthService _authService = AuthService();
  final Repository _repository = Repository();

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is ContinueButtonEvent) {
      yield ContinueState();
    } else if (event is SignupButtonEvent) {
      yield LoadingState();
      UserModel userModel = UserModel(
        name: nameValue,
        phone: phoneValue,
        email: emailValue,
        username: usernameValue,
        password: passwordValue,
        date: DateTime.now(),
      );

      print('${userModel.name}');

      var _result = await registerWithEmailAndPassword(userModel);
      yield _result is UserModel
          ? SuccessState(userModel: _result)
          : FailureState(errorMessage: _result);
    } else if (event is BackEvent) {
      yield SignupInitial();
    }
  }

  //user registration with email and password
  Future registerWithEmailAndPassword(UserModel userModel) async {
    try {
      //register user
      var _result = await _authService.registerWithEmailAndPassword(userModel);
      //store user to database
      if (_result is UserModel) {
        await _repository.createUser(_result);
        print("${_result.password} and ${_result.password}");
      }
      return _result;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  Stream<String> get name => authStream.nameStream;
  Stream<String> get phone => authStream.phoneStream;
  Stream<String> get email => authStream.emailStream;
  Stream<bool> get continueStream => authStream.continueStream;
  Function(String) get nameSink => authStream.nameSink;
  Function(String) get phoneSink => authStream.phoneSink;
  Function(String) get emailSink => authStream.emailSink;

  Stream<String> get username => authStream.usernameStream;
  Stream<String> get password1 => authStream.password1Stream;
  Stream<String> get password2 => authStream.password2Stream;
  Stream<bool> get signupStream => authStream.signupStream;
  Function(String) get usernameSink => authStream.usernameSink;
  Function(String) get password1Sink => authStream.password1Sink;
  Function(String) get password2Sink => authStream.password2Sink;

  String nameValue;
  String phoneValue;
  String emailValue;
  String usernameValue;
  String passwordValue;
}

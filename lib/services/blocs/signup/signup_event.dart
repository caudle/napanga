part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class ContinueButtonEvent extends SignupEvent {
  @override
  List<Object> get props => [];
}

class SignupButtonEvent extends SignupEvent {
  @override
  List<Object> get props => [];
}

class BackEvent extends SignupEvent {}

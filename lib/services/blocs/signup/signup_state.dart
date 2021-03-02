part of 'signup_bloc.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitial extends SignupState {
  @override
  List<Object> get props => [];
}

class ContinueState extends SignupState {
  @override
  List<Object> get props => [];
}

class LoadingState extends SignupState {}

class SuccessState extends SignupState {
  final UserModel userModel;
  SuccessState({@required this.userModel});
}

class FailureState extends SignupState {
  final String errorMessage;
  FailureState({@required this.errorMessage});
}

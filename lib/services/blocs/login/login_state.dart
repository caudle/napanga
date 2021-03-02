part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoadingState extends LoginState {}

class SuccessState extends LoginState {}

class FailureState extends LoginState {
  final errorMessage;
  FailureState({@required this.errorMessage});
}

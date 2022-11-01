// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_cubit.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginModel loginModel;
  LoginSuccessState(
    this.loginModel,
  );
}

class LoginErrrorState extends LoginState {
  final String error;

  LoginErrrorState(this.error);
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final String errorMessage;
  const LoginFailure({
    required this.errorMessage,
  });
}

class SignOutSuccess extends LoginState {}

class SignOutLoading extends LoginState {}

class SignOutFailure extends LoginState {
  final String errorMessage;
  const SignOutFailure({
    required this.errorMessage,
  });
}

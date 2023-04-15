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
  final String erorrMessage;
  const LoginFailure({
    required this.erorrMessage,
  });
}

class SignOutSuccess extends LoginState {}

class SignOutLoading extends LoginState {}

class SignOutFailure extends LoginState {
  final String erorrMessage;
  const SignOutFailure({
    required this.erorrMessage,
  });
}

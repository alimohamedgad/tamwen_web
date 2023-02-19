// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tamwen_cubit.dart';

abstract class TamwenState {}

class TamwenInitial extends TamwenState {}

class InsertState extends TamwenState {}

class UsersLoading extends TamwenState {}

class UsersFaliure extends TamwenState {}

class UsersSuccess extends TamwenState {
  List<UserModel> users;
  UsersSuccess({
    required this.users,
  });
}

class AddUserSuccess extends TamwenState {}

class AddUserLoading extends TamwenState {}

class AddUserFailure extends TamwenState {}

class UpdateUserSuccess extends TamwenState {}

class UpdateUserFailure extends TamwenState {}

class DeleteUserSuccess extends TamwenState {}

class DeleteUserFailure extends TamwenState {}

class GetDefrenetUserSuccess extends TamwenState {}

class GetDefrenetUserLoading extends TamwenState {}

class GetDefrenetUserFailure extends TamwenState {}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tamwen_web/Featurs/Model/user.dart';

abstract class PeopleState {}

class PeopleInitial extends PeopleState {}

class InsertState extends PeopleState {}

class UsersLoading extends PeopleState {}

class UsersFaliure extends PeopleState {}

class UsersSuccess extends PeopleState {
  List<UserModel> users;
  UsersSuccess({
    required this.users,
  });
}

class AddUserSuccess extends PeopleState {}

class AddUserLoading extends PeopleState {}

class AddUserFailure extends PeopleState {}

class UpdateUserSuccess extends PeopleState {}

class UpdateUserFailure extends PeopleState {}

class DeleteUserSuccess extends PeopleState {}

class DeleteUserFailure extends PeopleState {}

class GetDefrenetUserSuccess extends PeopleState {}

class GetDefrenetUserLoading extends PeopleState {}

class GetDefrenetUserFailure extends PeopleState {}

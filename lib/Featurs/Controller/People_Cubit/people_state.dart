// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class ClientState {}

class PeopleInitial extends ClientState {}

class InsertState extends ClientState {}

class UsersLoading extends ClientState {}

class UsersFaliure extends ClientState {}

class UsersSuccess extends ClientState {}

class AddUserSuccess extends ClientState {}

class AddUserLoading extends ClientState {}

class AddUserFailure extends ClientState {}

class UpdateUserSuccess extends ClientState {}

class UpdateUserFailure extends ClientState {}

class UpdateUserLoading extends ClientState {}

class DeleteUserSuccess extends ClientState {}

class DeleteUserFailure extends ClientState {}

class GetDefrenetUserSuccess extends ClientState {}

class GetDefrenetUserLoading extends ClientState {}

class GetDefrenetUserFailure extends ClientState {}

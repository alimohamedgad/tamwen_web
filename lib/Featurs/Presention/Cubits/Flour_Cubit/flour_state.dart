part of 'flour_cubit.dart';

abstract class FlourState extends Equatable {
  const FlourState();

  @override
  List<Object> get props => [];
}

class FlourInitial extends FlourState {}

class GetFlourSuccess extends FlourState {}

class GetFlourLoading extends FlourState {}

class GetFlourFailure extends FlourState {}

class AddFlourSuccess extends FlourState {}

class AddFlourLoading extends FlourState {}

class AddFlourFailure extends FlourState {}

class UpdateFlourSuccess extends FlourState {}

class UpdateFlourLoading extends FlourState {}

class UpdateFlourFailure extends FlourState {}

class DeleteFlourSuccess extends FlourState {}

class DeleteFlourLoading extends FlourState {}

class DeleteFlourFailure extends FlourState {}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CardModel extends Equatable {
  final int numberPerson;
  final int numberPersonInList;
  final Object isEqualTo;

  const CardModel({
    this.numberPerson = 0,
    this.numberPersonInList = 0,
    this.isEqualTo = 0,
  });

  CardModel copyWith({
    int? numberPerson,
    int? numberPersonInList,
    Object? isEqualTo,
  }) {
    return CardModel(
      numberPerson: numberPerson ?? this.numberPerson,
      numberPersonInList: numberPersonInList ?? this.numberPersonInList,
      isEqualTo: isEqualTo ?? this.isEqualTo,
    );
  }

  @override
  List<Object> get props => [numberPerson, numberPersonInList, isEqualTo];
}

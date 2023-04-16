// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CardModel extends Equatable {
  final int numberPerosn;
  final int numberPersonInList;
  final Object isEqualTo;

  const CardModel({
    this.numberPerosn = 0,
    this.numberPersonInList = 0,
    this.isEqualTo = 0,
  });

  CardModel copyWith({
    int? numberPerosn,
    int? numberPersonInList,
    Object? isEqualTo,
  }) {
    return CardModel(
      numberPerosn: numberPerosn ?? this.numberPerosn,
      numberPersonInList: numberPersonInList ?? this.numberPersonInList,
      isEqualTo: isEqualTo ?? this.isEqualTo,
    );
  }

  @override
  List<Object> get props => [numberPerosn, numberPersonInList, isEqualTo];
}

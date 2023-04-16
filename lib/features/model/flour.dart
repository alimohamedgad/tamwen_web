// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class FlourModel extends Equatable {
  final String nameClient;
  final int amountFlour;
  final String round;
  String? id;

  FlourModel({
    this.nameClient = '',
    this.amountFlour = 0,
    this.round = '',
    this.id = '',
  });

  factory FlourModel.fromJson(json) {
    return FlourModel(
        nameClient: json['nameClient'],
        amountFlour: json['amountFlour'],
        round: json['round'],
        id: json['id']);
  }

  toJson() {
    return {
      'nameClient': nameClient,
      'amountFlour': amountFlour,
      'round': round,
      'id': id,
    };
  }

  FlourModel copyWith({
    String? nameClient,
    int? amountFlour,
    String? round,
    String? id,
  }) {
    return FlourModel(
      nameClient: nameClient ?? this.nameClient,
      amountFlour: amountFlour ?? this.amountFlour,
      round: round ?? this.round,
      id: id ?? this.id,
    );
  }

  @override
  List<Object> get props => [
        nameClient,
        amountFlour,
        round,
        id!,
      ];
}

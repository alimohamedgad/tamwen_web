// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  String? id;
  final String name;
  final int numberOfMainPeople;
  final int numberOfExtraPeople;
  final int priceOfExtraPerople;
  final int password;

  UserModel({
    this.id,
    this.name = '',
    this.numberOfMainPeople = 0,
    this.numberOfExtraPeople = 0,
    this.priceOfExtraPerople = 0,
    this.password = 0,
  });

  toJson() {
    return {
      'id': id,
      'name': name,
      'numberOfMainPeople': numberOfMainPeople,
      'numberOfExtraPeople': numberOfExtraPeople,
      'priceOfExtraPerople': priceOfExtraPerople,
      'password': password,
    };
  }

  factory UserModel.fromJson(json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      numberOfExtraPeople: json['numberOfExtraPeople'],
      numberOfMainPeople: json['numberOfMainPeople'],
      priceOfExtraPerople: json['priceOfExtraPerople'],
      password: json['password'],
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    int? numberOfMainPeople,
    int? numberOfExtraPeople,
    int? priceOfExtraPerople,
    int? password,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      numberOfMainPeople: numberOfMainPeople ?? this.numberOfMainPeople,
      numberOfExtraPeople: numberOfExtraPeople ?? this.numberOfExtraPeople,
      priceOfExtraPerople: priceOfExtraPerople ?? this.priceOfExtraPerople,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props {
    return [
      id!,
      name,
      numberOfMainPeople,
      numberOfExtraPeople,
      priceOfExtraPerople,
      password,
    ];
  }
}

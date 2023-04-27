// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  String? id;
  final String name;
  final int numberOfMainPeople;
  final int numberOfExtraPeople;
  final int price;
  final int password;
  UserModel({
    this.id,
    required this.name,
    required this.numberOfMainPeople,
    required this.numberOfExtraPeople,
    required this.price,
    required this.password,
  });

  toJson() {
    return {
      'id': id,
      'name': name,
      'numberOfMainPeople': numberOfMainPeople,
      'numberOfExtraPeople': numberOfExtraPeople,
      'price': price,
      'password': password,
    };
  }

  factory UserModel.fromJson(json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      numberOfExtraPeople: json['numberOfExtraPeople'],
      numberOfMainPeople: json['numberOfMainPeople'],
      price: json['price'],
      password: json['password'],
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    int? numberOfMainPeople,
    int? numberOfExtraPeople,
    int? price,
    int? password,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      numberOfMainPeople: numberOfMainPeople ?? this.numberOfMainPeople,
      numberOfExtraPeople: numberOfExtraPeople ?? this.numberOfExtraPeople,
      price: price ?? this.price,
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
      price,
      password
    ];
  }
}

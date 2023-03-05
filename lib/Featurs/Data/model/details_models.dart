// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class DetailsModel extends Equatable {
  final double price;
  String? id;
  final String? image;
  final String? nameProduct;
  int quantity;
  final int dateTime;
  DetailsModel({
    this.price = 0,
    this.id,
    this.image = 'لا يوجد صوره',
    this.nameProduct = '',
    this.quantity = 0,
    required this.dateTime,
  });

  factory DetailsModel.fromJson(json) {
    return DetailsModel(
      image: json['imageProduct'],
      price: json['priceForOneProduct'],
      id: json['id'],
      nameProduct: json['nameProduct'],
      quantity: json['quantity'],
      dateTime: json['dateTime'],
    );
  }

  toJsonDoc() {
    return {
      'id': id,
      'nameProduct': nameProduct,
      'priceForOneProduct': price,
      'imageProduct': image,
      'quantity': quantity,
      'dateTime': dateTime,
    };
  }

  @override
  List<Object?> get props {
    return [
      price,
      id,
      image,
      nameProduct,
      quantity,
      dateTime,
    ];
  }

  DetailsModel copyWith({
    double? price,
    String? id,
    String? image,
    String? nameProduct,
    int? quantity,
    int? dateTime,
  }) {
    return DetailsModel(
      price: price ?? this.price,
      id: id ?? this.id,
      image: image ?? this.image,
      nameProduct: nameProduct ?? this.nameProduct,
      quantity: quantity ?? this.quantity,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}

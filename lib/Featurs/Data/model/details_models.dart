// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class DetailsModel extends Equatable {
  final double price;
  String? id;
  final String? image;
  final String? nameProduct;
  int quantity;
  DetailsModel({
    this.price = 0,
    this.id,
    this.image = 'لا يوجد صوره',
    this.nameProduct = '',
    this.quantity = 0,
  });

  factory DetailsModel.fromJson(json) {
    return DetailsModel(
      image: json['imageProduct'],
      price: json['priceForOneProduct'],
      id: json['id'],
      nameProduct: json['nameProduct'],
      quantity: json['quantity'],
    );
  }

  toJsonDoc() {
    return {
      'id': id,
      'nameProduct': nameProduct,
      'priceForOneProduct': price,
      'imageProduct': image,
      'quantity': quantity,
    };
  }

  @override
  List<Object> get props => [
        price,
      ];

  DetailsModel copyWith({
    double? price,
    double? quantite,
    String? id,
    String? image,
    String? nameProduct,
    int? quantity,
  }) {
    return DetailsModel(
      price: price ?? this.price,
      id: id ?? this.id,
      image: image ?? this.image,
      nameProduct: nameProduct ?? this.nameProduct,
      quantity: quantity ?? this.quantity,
    );
  }
}

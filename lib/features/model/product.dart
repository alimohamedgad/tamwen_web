// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final dynamic price;
  String? id;
  final String? image;
  final String? nameProduct;
  final dynamic quantity;
  final dynamic dateTime;
  ProductModel({
    this.price = 0,
    this.id,
    this.image = 'لا يوجد صوره',
    this.nameProduct = '',
    this.quantity = 0,
    required this.dateTime,
  });

  factory ProductModel.fromJson(json) {
    return ProductModel(
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

  ProductModel copyWith({
    dynamic price,
    String? id,
    String? image,
    String? nameProduct,
    double? quantity,
    int? dateTime,
  }) {
    return ProductModel(
      price: price ?? this.price,
      id: id ?? this.id,
      image: image ?? this.image,
      nameProduct: nameProduct ?? this.nameProduct,
      quantity: quantity ?? this.quantity,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:tamwen_web/Featurs/Data/model/product.dart';

class FilterProductModel extends Equatable {
  final ProductModel productModel;
  final String id;
  final bool value;
  const FilterProductModel({
    required this.productModel,
    required this.id,
    required this.value,
  });

  FilterProductModel copyWith({
    ProductModel? productModel,
    String? id,
    bool? value,
  }) {
    return FilterProductModel(
      productModel: productModel ?? this.productModel,
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  @override
  List<Object> get props => [productModel, id, value];
}

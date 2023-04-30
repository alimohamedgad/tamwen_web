// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class GetProductsSuccess extends ProductState {}

class GetProductsSFaliure extends ProductState {}

class GetProductsLoading extends ProductState {}

class ProductAddSuccess extends ProductState {}

class ProductAddFailure extends ProductState {}

class ProductAddLoading extends ProductState {}

class DeleteProductLoading extends ProductState {}

class DeleteProductSuccess extends ProductState {}

class DeleteProductFaliure extends ProductState {}

class ProductUpdateSuccess extends ProductState {}

class ProductUpdateLoading extends ProductState {}

class ProductUpdateFailure extends ProductState {}

class Product extends ProductState {}

class FilterProductLoading extends ProductState {}

class FilterProductSuccess extends ProductState {}

class FilterProductError extends ProductState {}

class GetDataByMonth extends ProductState {}

class MaxState extends ProductState {}

class NewValueState extends ProductState {
  final double value;
  const NewValueState({
    required this.value,
  });
}

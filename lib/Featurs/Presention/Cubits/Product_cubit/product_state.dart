part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class GetProductsSuccess extends ProductState {
  final List<DetailsModel> details;

  const GetProductsSuccess({required this.details});
}

class GetProductsSFaliure extends ProductState {}

class GetProductsLoading extends ProductState {}

class ProductAddSuccess extends ProductState {}

class ProductAddFailure extends ProductState {}

class ProductAddLoading extends ProductState {}

class DeleteProductLoading extends ProductState {}

class DeleteProductSuccess extends ProductState {}

class DeleteProductFaliure extends ProductState {}

class ProductUpdateSuccess extends ProductState {}

class ProductUpdateFailure extends ProductState {}

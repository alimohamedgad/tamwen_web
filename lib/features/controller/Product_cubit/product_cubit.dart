import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Core/AppColors/app_colors.dart';
import '../../../Core/Services/utils.dart';
import '../../Model/product.dart';
import '../../model/user.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  static ProductCubit get(context) => BlocProvider.of(context);

  final _db = FirebaseFirestore.instance.collection('users');
  List<ProductModel> product = [];
  static List<ProductModel> productFilter = [];

  List<ProductModel> get filterProductName {
    return productFilter
        .fold<Map<String, ProductModel>>({}, (map, product) {
          map.putIfAbsent(product.nameProduct!, () => product);
          return map;
        })
        .values
        .toList();
  }

  getProduct(UserModel userModel) {
    emit(GetProductsLoading());
    try {
      _db.doc(userModel.id).collection('products').snapshots().listen((event) {
        product.clear();
        for (var e in event.docs) {
          product.add(ProductModel.fromJson(e));
        }
        emit(GetProductsSuccess());
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      emit(GetProductsSFaliure());
    }
  }

  getAllProducts() {
    emit(FilterProductLoading());
    try {
      final db = FirebaseFirestore.instance;
      db.collectionGroup('products').snapshots().listen((event) {
        productFilter.clear();
        for (var product in event.docs) {
          productFilter.add(ProductModel.fromJson(product));
          emit(FilterProductSuccess());
        }
      });
    } on Exception catch (e) {
      emit(FilterProductError());
    }
  }

  Future<void> addProduct(ProductModel model, String id) async {
    emit(ProductAddLoading());
    final document = _db.doc(id).collection('products').doc();
    model.id = document.id;

    try {
      await document.set(model.toJsonDoc());
      emit(ProductAddSuccess());
    } catch (e) {
      Utils.snackBar(e.toString(), AppColors.red);
      emit(ProductAddFailure());
    }
  }

  Future<void> deleteProduct(String id, ProductModel details) {
    emit(DeleteProductLoading());
    return _db
        .doc(id)
        .collection('products')
        .doc(details.id)
        .delete()
        .then((value) {
      Utils.snackBar(
          "لقد قمت ب حذف ${details.nameProduct} من القائمة  ", AppColors.red);
      emit(DeleteProductSuccess());
    }).catchError((e) {
      Utils.snackBar(e.toString(), AppColors.red);
      emit(DeleteProductFaliure());
    });
  }

  Future updateProduct(ProductModel productModel, String userID) async {
    emit(ProductUpdateLoading());
    final docRef = _db.doc(userID).collection('products').doc(productModel.id);
    try {
      await docRef.update(productModel.toJsonDoc());
      emit(ProductUpdateSuccess());
    } catch (e) {
      emit(ProductUpdateFailure());
    }
  }

  getTotalPrice(List<ProductModel> detailsList) {
    double totalPrice = 0.0;
    for (var element in detailsList) {
      totalPrice += element.price * element.quantity;
    }
    return totalPrice;
  }

  double maxPrice = 12;

  double value = 0;
  void changeValue(double newValue) {
    value = newValue;
    emit(NewValueState(value: value));
  }
}

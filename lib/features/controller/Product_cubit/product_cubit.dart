import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamwen_web/Core/AppColors/app_colors.dart';
import 'package:tamwen_web/Core/Services/utils.dart';
import '../../Model/product.dart';
import '../../Model/user.dart';

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
      emit(FilterProductErorr());
    }
  }

  Future addProduct(ProductModel model, String id) async {
    emit(ProductAddLoading());
    final docuser = _db.doc(id).collection('products').doc();
    model.id = docuser.id;

    try {
      await docuser.set(model.toJsonDoc());
      Utils.snackBar('لقد قمت ب أضافة منتح جديد', AppColors.green);
      emit(ProductAddSuccess());
    } catch (e) {
      Utils.snackBar(e.toString(), AppColors.red);
      emit(ProductAddFailure());
    }
  }

  deleteProduct(String id, ProductModel details) {
    emit(DeleteProductLoading());
    _db.doc(id).collection('products').doc(details.id).delete().then((value) {
      Utils.snackBar(
          "لقد قمت ب حذف ${details.nameProduct} من القائمة  ", AppColors.red);
      emit(DeleteProductSuccess());
    }).catchError((e) {
      Utils.snackBar(e.toString(), AppColors.red);
      emit(DeleteProductFaliure());
    });
  }

  Future updateProduct(ProductModel productModel, String userID) async {
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

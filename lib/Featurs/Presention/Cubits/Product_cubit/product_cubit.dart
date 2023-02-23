import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Core/AppColors/app_colors.dart';
import '../../../Core/utils.dart';
import '../../../Data/model/details_models.dart';
import '../../../Data/model/user_model.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  var db = FirebaseFirestore.instance;
  List<DetailsModel> details = [];
  getAllProducts(UserModel userModel) {
    emit(GetProductsLoading());
    try {
      db
          .collection('users')
          .doc(userModel.id)
          .collection('products')
          .snapshots()
          .listen((event) {
        details.clear();
        for (var product in event.docs) {
          details.add(DetailsModel.fromJson(product));
        }
        emit(GetProductsSuccess(details: details));
      });
    } on Exception catch (e) {
      emit(GetProductsSFaliure());
    }
  }

  getAllProducts2() {
    emit(GetProductsLoading());
    try {
      db
          .collection('users')
          .doc()
          .collection('products')
          .snapshots()
          .listen((event) {
        details.clear();
        for (var product in event.docs) {
          details.add(DetailsModel.fromJson(product));
        }
        emit(GetProductsSuccess(details: details));
      });
    } on Exception catch (e) {
      emit(GetProductsSFaliure());
    }
  }

  Future addProduct(DetailsModel model, String id) async {
    emit(ProductAddLoading());
    final docuser = db.collection('users').doc(id).collection('products').doc();
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

  deleteProduct(String id, String idProduct, DetailsModel details) {
    emit(DeleteProductLoading());
    db
        .collection('users')
        .doc(id)
        .collection('products')
        .doc(idProduct)
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

  Future updateProduct(DetailsModel detailsModel, String userID) async {
    final docRef = db
        .collection('users')
        .doc(userID)
        .collection('products')
        .doc(detailsModel.id);
    final updateProduct = DetailsModel(
      id: detailsModel.id,
      nameProduct: detailsModel.nameProduct,
      quantity: detailsModel.quantity,
      image: detailsModel.image,
      price: detailsModel.price,
    ).toJsonDoc();
    try {
      await docRef.update(updateProduct);
      emit(ProductUpdateSuccess());
    } catch (e) {
      print(e.toString());
      emit(ProductUpdateFailure());
    }
  }

  getTotalPrice(List<DetailsModel> detailsList) {
    double totalPrice = 0.0;
    for (var element in detailsList) {
      totalPrice += element.price * element.quantity;
    }
    return totalPrice;
  }
}

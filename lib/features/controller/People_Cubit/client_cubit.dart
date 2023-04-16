import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamwen_web/Core/Services/utils.dart';
import 'package:tamwen_web/features/Controller/People_Cubit/people_state.dart';
import '../../Model/user.dart';
import '../../../Core/AppColors/app_colors.dart';

class ClientCubit extends Cubit<ClientState> {
  ClientCubit() : super(PeopleInitial());
  static ClientCubit get(context) => BlocProvider.of(context);

  final _db = FirebaseFirestore.instance.collection('users');
  List<UserModel> users = [];
  List<UserModel> differentUser = [];

  void getUser() {
    try {
      emit(UsersLoading());
      _db.orderBy('numberOfMainPeople').snapshots().listen((event) {
        users.clear();
        for (var doc in event.docs) {
          users.add(UserModel.fromJson(doc));
        }
        emit(UsersSuccess());
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      emit(UsersFaliure());
    }
  }

  void getDifferentUser(Object? isEqualTo) {
    emit(GetDefrenetUserLoading());
    try {
      _db
          .where('numberOfMainPeople', isEqualTo: isEqualTo)
          .snapshots()
          .listen((event) {
        differentUser.clear();

        for (var user in event.docs) {
          differentUser.add(UserModel.fromJson(user));
        }
        emit(GetDefrenetUserSuccess());
      });
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      emit(GetDefrenetUserFailure());
    }
  }

  Future<void> addUsers(UserModel model) async {
    try {
      // emit(AddUserLoading());
      final docuser = _db.doc();
      model.id = docuser.id;
      await docuser.set(model.toJson());
      emit(AddUserSuccess());
    } catch (e) {
      Utils.snackBar(e.toString(), AppColors.red);
      emit(AddUserFailure());
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      emit(UpdateUserLoading());
      final docuser = _db.doc(user.id);
      await docuser.update(user.toJson());
      emit(UpdateUserSuccess());
      // Utils.snackBar('لقد قمت بتحديث بطاقة ${user.name}', AppColors.green);
    } catch (e) {
      Utils.snackBar(e.toString(), AppColors.red);
    }
  }

  Future<void> deleteUser(UserModel user) async {
    try {
      await _db.doc(user.id).delete().then((value) {});
      Utils.snackBar(
          'لقد قمت بحذف بطاقة ${user.name}', AppColors.green.withOpacity(0.9));
      emit(DeleteUserSuccess());
    } catch (e) {
      Utils.snackBar(e.toString(), AppColors.red);
      emit(DeleteUserSuccess());
    }
  }

  String? selectedProductName;
  String? selectedImage;
  Object? selectedQuantite;

  Object? numMainPeopleSelected;
  Object? numExtraPeopleSelected;
  Object? priceOfExtraPeopleSelected;
}
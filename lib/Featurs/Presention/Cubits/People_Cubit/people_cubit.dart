import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamwen_web/Featurs/Core/Services/utils.dart';
import '../../../Data/model/user_model.dart';
import 'people_state.dart';
import '../../../Core/AppColors/app_colors.dart';

class PeopleCubit extends Cubit<PeopleState> {
  PeopleCubit() : super(PeopleInitial());
  static PeopleCubit get(context) => BlocProvider.of(context);

  final _db = FirebaseFirestore.instance.collection('users');
  List<UserModel> users = [];
  List<UserModel> differentUser = [];

  void getUser() {
    _db.orderBy('numberOfMainPeople').snapshots().listen((event) {
      users.clear();
      for (var doc in event.docs) {
        users.add(UserModel.fromJson(doc));
      }
      emit(UsersSuccess(users: users));
    });
  }

  void getDifferentUser(Object? isEqualTo) {
    emit(GetDefrenetUserLoading());
    _db
        .where('numberOfMainPeople', isEqualTo: isEqualTo)
        .snapshots()
        .listen((event) {
      differentUser.clear();

      for (var user in event.docs) {
        differentUser.add(UserModel.fromJson(user));
        emit(GetDefrenetUserSuccess());
      }
    });
  }

  Future<void> addUsers(UserModel model) async {
    emit(AddUserLoading());

    final docuser = _db.doc();
    model.id = docuser.id;
    try {
      await docuser.set(model.toJson());
      Utils.snackBar('لقد قمت ب اضافة بطاقة جديدة', AppColors.green);
      emit(AddUserSuccess());
    } catch (e) {
      Utils.snackBar(e.toString(), AppColors.green);
      emit(AddUserFailure());
    }
  }

  Future<void> updateUser(UserModel user) async {
    final docuser = _db.doc(user.id);
    try {
      await docuser.update(user.toJson());
      Utils.snackBar('لقد قمت بتحديث بطاقة ${user.name}', AppColors.green);

      emit(UpdateUserSuccess());
    } catch (e) {
      Utils.snackBar(e.toString(), AppColors.green);

      emit(UpdateUserSuccess());
    }
  }

  Future<void> deleteUser(UserModel user) async {
    try {
      await _db.doc(user.id).delete();
      Utils.snackBar('لقد قمت بحذف بطاقة ${user.name}', AppColors.green);

      emit(DeleteUserSuccess());
    } catch (e) {
      emit(DeleteUserSuccess());
      Utils.snackBar(e.toString(), AppColors.green);
    }
  }

  String? selectedProductName;
  String? selectedImage;
  Object? selectedQuantite;

  Object? numMainPeopleSelected;
  Object? numExtraPeopleSelected;
  Object? priceOfExtraPeopleSelected;
}

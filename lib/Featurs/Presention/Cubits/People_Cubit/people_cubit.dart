import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamwen_web/Featurs/Data/model/user_model.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/People_Cubit/people_state.dart';
import '../../../Core/AppColors/app_colors.dart';
import '../../../Core/utils.dart';

import '../../../Data/model/details_models.dart';

class PeopleCubit extends Cubit<PeopleState> {
  PeopleCubit() : super(PeopleInitial());
  static PeopleCubit get(context) => BlocProvider.of(context);

  var db = FirebaseFirestore.instance;
  List<UserModel> users = [];
  List<UserModel> deferentUserList = [];

  getAllUsers() {
    db
        .collection('users')
        .orderBy('numberOfMainPeople')
        .snapshots()
        .listen((event) {
      users.clear();
      for (var doc in event.docs) {
        users.add(UserModel.fromJson(doc));
      }
      emit(UsersSuccess(users: users));
    });
  }

  getAllUsersForDeferentPerson(Object? isEqualTo) {
    emit(GetDefrenetUserLoading());
    db
        .collection('users')
        .where('numberOfMainPeople', isEqualTo: isEqualTo)
        .snapshots()
        .listen((event) {
      deferentUserList.clear();

      for (var user in event.docs) {
        deferentUserList.add(UserModel.fromJson(user));
        emit(GetDefrenetUserSuccess());
      }
    });
  }

  int index = 0;
  Future<void> addUsers(UserModel model) async {
    emit(AddUserLoading());

    final docuser = db.collection('users').doc();
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

  Future updateUser(UserModel user) async {
    final docuser = db.collection('users').doc(user.id);
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
      await db.collection('users').doc(user.id).delete();
      Utils.snackBar('لقد قمت بحذف بطاقة ${user.name}', AppColors.green);

      emit(DeleteUserSuccess());
    } catch (e) {
      emit(DeleteUserSuccess());
      Utils.snackBar(e.toString(), AppColors.green);
    }
  }

  List<DetailsModel> nameProductList = [
    DetailsModel(
        nameProduct: 'سكر تموين', id: '1', dateTime: DateTime.now().month),
    DetailsModel(
        nameProduct: 'زيت تموين', id: '2', dateTime: DateTime.now().month),
    DetailsModel(
        nameProduct: 'مكرونة', id: '3', dateTime: DateTime.now().month),
    DetailsModel(
        nameProduct: 'سكر حر', id: '4', dateTime: DateTime.now().month),
    DetailsModel(
        nameProduct: 'زيت حر', id: '5', dateTime: DateTime.now().month),
    DetailsModel(nameProduct: 'ملح', id: '6', dateTime: DateTime.now().month),
    DetailsModel(nameProduct: 'رز', id: '7', dateTime: DateTime.now().month),
    DetailsModel(
        nameProduct: 'شاى عروسه كبير', id: '8', dateTime: DateTime.now().month),
    DetailsModel(
        nameProduct: 'شاى عروسه صغير', id: '9', dateTime: DateTime.now().month),
    DetailsModel(
        nameProduct: 'شاى ليبتون كبير',
        id: '10',
        dateTime: DateTime.now().month),
    DetailsModel(
        nameProduct: 'شاى ليبتون صغير',
        id: '11',
        dateTime: DateTime.now().month),
    DetailsModel(
        nameProduct: 'حلاوة كبيره', id: '12', dateTime: DateTime.now().month),
    DetailsModel(
        nameProduct: 'حلاوة صغيره', id: '13', dateTime: DateTime.now().month),
    DetailsModel(
        nameProduct: 'سمنه سايبه', id: '14', dateTime: DateTime.now().month),
    DetailsModel(
        nameProduct: 'سمنه كيلوا', id: '15', dateTime: DateTime.now().month),
    DetailsModel(
        nameProduct: 'سمنه 2 كيلوا', id: '16', dateTime: DateTime.now().month),
    DetailsModel(
        nameProduct: 'سمنه 3 كيلوا', id: '17', dateTime: DateTime.now().month),
    DetailsModel(nameProduct: 'مربى', id: '18', dateTime: DateTime.now().month),
    DetailsModel(
        nameProduct: 'طماطم', id: '19', dateTime: DateTime.now().month),
    DetailsModel(
        nameProduct: 'تونة قطع', id: '20', dateTime: DateTime.now().month),
    DetailsModel(
        nameProduct: 'تونة مفتته', id: '21', dateTime: DateTime.now().month),
    DetailsModel(
        nameProduct: 'مرقة دجاج', id: '22', dateTime: DateTime.now().month),
  ];

  String? selectedProductName;
  String? selectedImage;
  int? selectedQuantite;

  List<String> priceForPersonList = [
    '30',
    '35',
    '40',
    '45',
    '50',
  ];

  Object? numMainPeopleSelected;
  Object? numExtraPeopleSelected;
  Object? priceOfExtraPeopleSelected;
}

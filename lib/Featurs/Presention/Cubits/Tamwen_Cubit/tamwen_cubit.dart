import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamwen_web/Featurs/Data/model/user_model.dart';
import '../../../Core/app_colors.dart';
import '../../../Core/utils.dart';
import '../../../Data/model/flour_model.dart';

import '../../../Data/model/details_models.dart';

part 'tamwen_state.dart';

class TamwenCubit extends Cubit<TamwenState> {
  TamwenCubit() : super(TamwenInitial());
  static TamwenCubit get(context) => BlocProvider.of(context);

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
    DetailsModel(nameProduct: 'سكر تموين', id: '1'),
    DetailsModel(nameProduct: 'زيت تموين', id: '2'),
    DetailsModel(nameProduct: 'مكرونة', id: '3'),
    DetailsModel(nameProduct: 'سكر حر', id: '4'),
    DetailsModel(nameProduct: 'زيت حر', id: '5'),
    DetailsModel(nameProduct: 'ملح', id: '6'),
    DetailsModel(nameProduct: 'رز', id: '7'),
    DetailsModel(nameProduct: 'شاى عروسه كبير', id: '8'),
    DetailsModel(nameProduct: 'شاى عروسه صغير', id: '9'),
    DetailsModel(nameProduct: 'شاى ليبتون كبير', id: '10'),
    DetailsModel(nameProduct: 'شاى ليبتون صغير', id: '11'),
    DetailsModel(nameProduct: 'حلاوة كبيره', id: '12'),
    DetailsModel(nameProduct: 'حلاوة صغيره', id: '13'),
    DetailsModel(nameProduct: 'سمنه سايبه', id: '14'),
    DetailsModel(nameProduct: 'سمنه كيلوا', id: '15'),
    DetailsModel(nameProduct: 'سمنه 2 كيلوا', id: '16'),
    DetailsModel(nameProduct: 'سمنه 3 كيلوا', id: '17'),
    DetailsModel(nameProduct: 'مربى', id: '18'),
    DetailsModel(nameProduct: 'طماطم', id: '19'),
    DetailsModel(nameProduct: 'تونة قطع', id: '20'),
    DetailsModel(nameProduct: 'تونة مفتته', id: '21'),
    DetailsModel(nameProduct: 'مرقة دجاج', id: '22'),
  ];

  String? selectedProductName;
  String? selectedImage;
  int? selectedQuantite;
  List<DetailsModel> imageWithNameProductList = [
    DetailsModel(image: 'assets/img/sugar.jpg', nameProduct: 'سكر'),
    DetailsModel(image: 'assets/img/zit_tamwen.jpg', nameProduct: 'زيت تموين'),
    DetailsModel(image: 'assets/img/rice.jpg', nameProduct: 'رز'),
    DetailsModel(image: 'assets/img/tea.jpg', nameProduct: 'شاى ليبتون'),
    DetailsModel(
        image: 'assets/img/tea_3arosa.jpg', nameProduct: 'شاى العروسه'),
    DetailsModel(image: 'assets/img/zit_afia.jpg', nameProduct: 'زيت حر'),
    DetailsModel(image: "assets/img/tona.jpg", nameProduct: 'تونه قطع'),
    DetailsModel(
        image: 'assets/img/tona_mftata.jpg', nameProduct: 'تونه مفتته'),
    DetailsModel(image: 'assets/img/samna.jpg', nameProduct: 'سمنه'),
    DetailsModel(image: 'assets/img/marba.jpg', nameProduct: 'مربة'),
    DetailsModel(image: 'assets/img/halawa.jpg', nameProduct: 'حلاوه'),
    DetailsModel(image: 'assets/img/mar2tDagag.jpeg', nameProduct: 'مرقة دجاج'),
  ];

  List<String> priceForPersonList = [
    '30',
    '35',
    '40',
    '45',
    '50',
  ];
  List<String> numberOfMainPeropleList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
  ];
  List<String> numberOfExtraPeropleList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
  ];
  List quantiteList = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
  ];

  String? numMainPeopleSelected;
  String? numExtraPeopleSelected;
  String? priceOfExtraPeopleSelected;

  String? selcetedAmountFlour;
  String? selectRound;

  List amountFlourList = [
    10,
    20,
    30,
    40,
    50,
    60,
  ];
  List<FlourModel> roundList = [
    FlourModel(round: 'الدور الاول'),
    FlourModel(round: 'الدور الثاني'),
    FlourModel(round: 'الدور الثالث'),
    FlourModel(round: 'الدور الرابع'),
  ];
  // List<FlourModel> flourList = [];
  // Future<List<FlourModel>> getFlours() async {
  //   var docsss = await db.collection('flour').orderBy('round').get();
  //   for (var element in docsss.docs) {
  //     flourList.add(FlourModel.fromJson(element.data()));
  //   }
  //   print(flourList.length);
  //   emit(FetchAllMessagesSuccessState());
  //   return flourList;
  // }
}

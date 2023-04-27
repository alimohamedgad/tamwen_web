import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Core/Services/utils.dart';

import '../../../Core/AppColors/app_colors.dart';
import '../../Model/flour.dart';

part 'flour_state.dart';

class FlourCubit extends Cubit<FlourState> {
  FlourCubit() : super(FlourInitial());

  static FlourCubit get(context) => BlocProvider.of(context);

  final db = FirebaseFirestore.instance;

  List<FlourModel> flourList = [];

  getFlours() {
    emit(GetFlourLoading());
    try {
      db.collection('flour').orderBy('round').snapshots().listen((event) {
        flourList.clear();
        for (var flour in event.docs) {
          flourList.add(FlourModel.fromJson(flour));
        }
        emit(GetFlourSuccess());
      });
    } on Exception catch (e) {
      emit(GetFlourFailure());
    }
  }

  Future<void> addFlour(FlourModel model) async {
    emit(AddFlourSuccess());
    final addFlour = db.collection('flour').doc();
    model.id = addFlour.id;

    try {
      await addFlour.set(model.toJson());
      Utils.snackBar(
          'لقد قمت ب اضافة ${model.amountFlour} كيلوا دقيق ل ${model.nameClient}',
          AppColors.green);
      emit(AddFlourSuccess());
    } catch (e) {
      Utils.snackBar(e.toString(), AppColors.red);
      emit(AddFlourFailure());
    }
  }

  Future<void> updateFlour(FlourModel model) async {
    emit(UpdateFlourLoading());
    final updateFlour = db.collection('flour').doc(model.id);
    model.id = updateFlour.id;
    try {
      await updateFlour.update(model.toJson());
      Utils.snackBar(
          'لقد قمت ب تحديث كمية الدقيق ل ${model.nameClient}', AppColors.green);
      emit(UpdateFlourSuccess());
    } catch (e) {
      Utils.snackBar(e.toString(), AppColors.red);
      emit(UpdateFlourFailure());
    }
  }

  Future<void> deleteFlour(FlourModel model) async {
    emit(DeleteFlourLoading());
    final deleteFlour = await db.collection('flour').doc(model.id).delete();
    try {
      Utils.snackBar('لقد قمت بحذف ${model.nameClient}', AppColors.red);
      emit(DeleteFlourSuccess());
      return deleteFlour;
    } catch (e) {
      Utils.snackBar(e.toString(), AppColors.red);
      emit(DeleteFlourFailure());
    }
  }

  String? selectedAmountFlour;
  String? selectRound;
}

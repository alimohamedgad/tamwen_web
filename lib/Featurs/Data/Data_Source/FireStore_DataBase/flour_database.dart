// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../../Core/app_colors.dart';
// import '../../../Core/utils.dart';

// import '../../model/flour_model.dart';

// class FlourDataBase {
//   static final db = FirebaseFirestore.instance;
//   static List<FlourModel> flourList = [];

//   static getFlours() {
//     return db.collection('flour').orderBy('round').snapshots();
//   }

//   static Future<void> addFlour(FlourModel model) async {
//     final addFlour = db.collection('flour').doc();
//     model.id = addFlour.id;

//     try {
//       await addFlour.set(model.toJson());
//       Utils.snackBar(
//           'لقد قمت ب اضافة ${model.amountFlour} كيلوا دقيق ل ${model.nameClient}',
//           AppColors.green);
//     } catch (e) {
//       Utils.snackBar(e.toString(), AppColors.red);
//     }
//   }

//   static Future<void> updateFlour(FlourModel model) async {
//     final updateFlour = db.collection('flour').doc(model.id);
//     model.id = updateFlour.id;
//     try {
//       await updateFlour.update(model.toJson());
//       Utils.snackBar(
//           'لقد قمت ب تحديث كمية الدقيق ل ${model.nameClient}', AppColors.green);
//     } catch (e) {
//       Utils.snackBar(e.toString(), AppColors.red);
//     }
//   }

//   static Future<void> deleteFlour(FlourModel model) async {
//     final deletFlour = await db.collection('flour').doc(model.id).delete();
//     try {
//       Utils.snackBar('لقد قمت بحذف ${model.nameClient}', AppColors.red);
//       return deletFlour;
//     } catch (e) {
//       Utils.snackBar(e.toString(), AppColors.red);
//     }
//   }
// }

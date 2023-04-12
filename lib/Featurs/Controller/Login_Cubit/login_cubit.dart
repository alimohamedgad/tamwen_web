import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamwen_web/Core/Services/utils.dart';

import '../../../Core/AppColors/app_colors.dart';
import '../../../Core/firebase_const.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    // await showDialog(
    //   context: context,
    //   builder: (context) => const Center(child: CircularProgressIndicator()),
    // );
    emit(LoginLoading());
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Utils.snackBar('تم تسجيل الدخول بنجاح', AppColors.green.withOpacity(0.9));
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(const LoginFailure(erorrMessage: 'البريد الالكتروني غير صحيح'));
      } else if (e.code == 'wrong-password') {
        emit(const LoginFailure(erorrMessage: 'الرقم السرى غير صحيح'));
      }
    } catch (e) {
      emit(const LoginFailure(erorrMessage: 'المدخلات غير صحيحه'));
    }
  }

  Future signOut(context) async {
    emit(SignOutLoading());
    try {
      await auth.signOut();
      Utils.snackBar('تم تسجيل الخروج بنجاح', AppColors.red);
      emit(SignOutSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Utils.snackBar(
            'لم يتم العثور على مستخدم لهذا البريد الإلكتروني', AppColors.red);
      } else if (e.code == 'wrong-password') {
        Utils.snackBar('الرقم السرى غير صحيح', AppColors.red);
      }
      emit(SignOutFailure());
    }
  }
}

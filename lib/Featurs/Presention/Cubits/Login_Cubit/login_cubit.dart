import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Core/AppColors/app_colors.dart';

import '../../../Core/utils.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final auth = FirebaseAuth.instance;
  Future signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    emit(LoginLoading());

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
      Utils.snackBar('تم تسجيل الدخول بنجاح', AppColors.green);
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

  bool isAdmin = false;

  isAdminChange(bool value) {
    isAdmin = !value;
    emit(IsAdmin(isAdmin: isAdmin));
  }

  Future signOut() async {
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
        print('Wrong password provided for that user.');
      }
      emit(SignOutFailure());
    }
  }
}

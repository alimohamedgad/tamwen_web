import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Core/Services/utils.dart';

import '../../../Core/AppColors/app_colors.dart';
import '../../../Core/App_String/login_string.dart';
import '../../../Core/firebase_const.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(LoginLoading());
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errorMessage: AuthString.wrongPassword));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errorMessage: AuthString.wrongEmail));
      }
    } catch (e) {
      emit(const LoginFailure(errorMessage: 'المدخلات غير صحيحه'));
    }
  }

  Future signOut() async {
    try {
      await auth.signOut();
      Utils.snackBar(AuthString.successSignOut, AppColors.green);
      emit(SignOutSuccess());
    } catch (e) {
      emit(const SignOutFailure(errorMessage: 'المدخلات غير صحيحه'));
    }
  }
}

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamwen_web/Core/firebase_const.dart';
import 'package:tamwen_web/features/Controller/Login_Cubit/login_cubit.dart';

import '../../../../Core/AppColors/app_colors.dart';
import '../../../../Core/App_String/login_string.dart';
import '../../../../Core/Services/global_method.dart';
import '../../../../Core/Services/utils.dart';
import '../../Widgets/CustomButton/custom_button.dart';
import '../../Widgets/Custom_Text/custom_text.dart';
import '../../Widgets/custom_text_field.dart';
import '../Home/home_page.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginCubit = BlocProvider.of<LoginCubit>(context);

    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          GlobalMethods.awesemDialog(context,
              message: state.errorMessage, dialogType: DialogType.error);
        } else if (state is LoginSuccess) {
          Utils.snackBar(AuthString.login, AppColors.green.withOpacity(0.9));
          GlobalMethods.navTo(const HomePage(), context);
        }
      },
      child: Scaffold(
        body: Align(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(
                    'assets/img/credit-cards-payment.png',
                    height: 120.h,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 450.h,
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 40.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.w),
                        topRight: Radius.circular(40.w),
                      ),
                      color: AppColors.white,
                    ),
                    child: Column(
                      children: [
                        CustomText(
                          'مرحبا بكم',
                          color: AppColors.black,
                          fontSize: 25.sp,
                        ),
                        CustomText(
                          'يرجي تسجيل الدخول',
                          color: AppColors.black,
                          fontSize: 25.sp,
                        ),
                        SizedBox(height: 15.h),
                        CustomTextfield(
                          keyBordTyp: TextInputType.emailAddress,
                          hintText: 'ادخل البريد الالكتروني',
                          controller: emailController,
                          icon: Icons.person,
                          colorIcon: Colors.black,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'يرجي ادخال البريد الالكتروني';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15.h),
                        CustomTextfield(
                          keyBordTyp: TextInputType.number,
                          hintText: 'ادخل الرقم السرى',
                          controller: passwordController,
                          icon: Icons.lock,
                          colorIcon: Colors.black,
                          obscureText: true,
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'يرجي ادخال الرقم السرى ';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10.h),
                        CustomButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await loginCubit.signIn(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                                context: context,
                              );
                            }
                          },
                          text: 'تسجيل الدخول',
                          color: AppColors.black,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

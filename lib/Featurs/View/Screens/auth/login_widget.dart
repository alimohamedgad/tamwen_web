import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamwen_web/Featurs/Controller/Login_Cubit/login_cubit.dart';
import 'package:tamwen_web/Featurs/View/Widgets/Custom_Text/custom_text.dart';

import '../../../../Core/AppColors/app_colors.dart';
import '../../../../Core/Services/global_method.dart';
import '../../Widgets/CustomButton/custom_button.dart';
import '../../Widgets/custom_text_field.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool isAdmin = false;
  final adminPassword = '01112723668';
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          GlobalMethods.awesemDialog(context,
              message: state.erorrMessage, dialogType: DialogType.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
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
                            text: 'مرحبا بكم',
                            color: AppColors.black,
                            fontSize: 25.sp,
                          ),
                          CustomText(
                            text: 'يرجي تسجيل الدخول',
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
                              var loginCubit =
                                  BlocProvider.of<LoginCubit>(context);

                              if (formKey.currentState!.validate()) {
                                if (emailController.text == 'admin@gmail.com' ||
                                    passwordController.text == '01112723668') {
                                } else {}
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
        );
      },
    );
  }
}

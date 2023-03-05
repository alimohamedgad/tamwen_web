import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../Core/AppColors/app_colors.dart';
import '../../../../Core/utils.dart';
import '../../../Cubits/Login_Cubit/login_cubit.dart';
import '../HomeScreen_Web/home_screnn_web.dart';
import '../../Mobile/Widgets/CustomButton/custom_button.dart';
import '../../Mobile/Widgets/Custom_Text/custom_text.dart';
import '../../Mobile/Widgets/custom_text_field.dart';
import '../../Mobile/Widgets/navigator.dart';
import '../HomeScreen_Web/side_bar.dart';

class LoginScreenWeb extends StatelessWidget {
  const LoginScreenWeb({super.key});

  static String id = 'LoginScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const CustomVerticalTabs();
          } else {
            return const LoginWidgetWeb();
          }
        },
      ),
    );
  }
}

class LoginWidgetWeb extends StatelessWidget {
  const LoginWidgetWeb({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          // Utils.snackBar('يرجي الانتظار', Colors.green);
        } else if (state is LoginSuccess) {
          customNavPush(const HomePageWeb(), context);
        } else if (state is LoginFailure) {
          Utils.snackBar(state.erorrMessage, Colors.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Center(
              child: Container(
                height: 450.h,
                margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: AppColors.textColor,
                  // gradient: LinearGradient(
                  //   colors: [
                  //     Colors.green,
                  //     Colors.black,
                  //     Colors.red,
                  //   ],
                  // ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    SizedBox(height: 10.h),
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
                    SizedBox(height: 10.h),
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
                        var loginCubit = BlocProvider.of<LoginCubit>(context);
                        if (formKey.currentState!.validate()) {
                          await loginCubit.signIn(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                              context: context);
                        }
                      },
                      text: 'تسجيل الدخول',
                      color: AppColors.black,
                    )
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

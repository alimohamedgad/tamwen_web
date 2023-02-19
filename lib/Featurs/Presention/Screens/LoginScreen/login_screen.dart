import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Core/app_colors.dart';
import '../../../Core/utils.dart';
import '../../Cubits/Login_Cubit/login_cubit.dart';
import '../HomeScreen/home_page.dart';
import '../../Widgets/CustomButton/custom_button.dart';
import '../../Widgets/Custom_Text/custom_text.dart';
import '../../Widgets/custom_text_field.dart';
import '../../Widgets/navigator.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static String id = 'LoginScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return const LoginWidget();
          }
        },
      ),
    );
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          Utils.snackBar('يرجي الانتظار', Colors.green);
        } else if (state is LoginSuccess) {
          customNavPush(const HomePage(), context);
        } else if (state is LoginFailure) {
          Utils.snackBar(state.erorrMessage, Colors.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 5, right: 5),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CustomText(
                      text: 'مرحبا بكم',
                      color: AppColors.white,
                      fontSize: 25,
                    ),
                    const CustomText(
                      text: 'يرجي تسجيل الدخول',
                      color: AppColors.white,
                      fontSize: 25,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.textColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                          const SizedBox(height: 10),
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
                          const SizedBox(height: 10),
                          CustomButton(
                            onPressed: () async {
                              var loginCubit =
                                  BlocProvider.of<LoginCubit>(context);
                              if (formKey.currentState!.validate()) {
                                await loginCubit.signIn(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                              }
                            },
                            text: 'تسجيل الدخول',
                            color: AppColors.black,
                          )
                        ],
                      ),
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

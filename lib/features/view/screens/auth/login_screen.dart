import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Get_it/get_it.dart';
import '../../../Controller/Login_Cubit/login_cubit.dart';
import 'login_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static String id = 'LoginScreen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => getIt<LoginCubit>(),
      child: const Scaffold(
        body: LoginWidget(),
      ),
    );
  }
}

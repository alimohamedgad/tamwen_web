import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tamwen_web/Core/firebase_const.dart';
import 'package:tamwen_web/Featurs/View/Screens/Admin/home_admin.dart';
import '../Home/home_page.dart';
import 'login_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static String id = 'LoginScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginWidget(),
      // body: StreamBuilder<User?>(
      //   stream: FirebaseAuth.instance.authStateChanges(),
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return const HomePage();
      //     } else {
      //       return const LoginWidget();
      //     }
      //   },
      // ),
    );
  }
}

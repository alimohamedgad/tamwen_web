import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../Featurs/View/Widgets/CustomButton/text_button.dart';
import '../../Featurs/View/Widgets/Custom_Text/custom_text.dart';

class GlobalMethods {
  static navTo(Widget newRoute, BuildContext context) {
    Navigator.push(
      context,
      PageTransition(
        child: newRoute,
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 600),
        reverseDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  static navRemoveUntil(Widget newRoute, context) {
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        child: newRoute,
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 600),
        reverseDuration: const Duration(milliseconds: 600),
      ),
      (route) => false,
    );
  }

  static Future<void> warningDialog(
    BuildContext context, {
    required String content,
    required String title,
    required Function() onTap,
  }) async {
    // final size = Utils(context).screenSize;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomText(text: title),
            ],
          ),
          content: CustomText(text: content),
          actions: [
            CusomtTextButton(
              text: 'لا',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CusomtTextButton(
              text: 'نعم',
              onPressed: onTap,
              color: Colors.red,
            ),
          ],
        );
      },
    );
  }

  static awesemDialog(context,
      {required DialogType dialogType, required String message}) {
    AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.bottomSlide,
      desc: message,
    ).show();
  }
}

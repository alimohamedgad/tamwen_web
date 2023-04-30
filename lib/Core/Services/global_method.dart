import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../features/View/Widgets/Custom_Text/custom_text.dart';
import '../../features/view/Widgets/CustomButton/text_button.dart';

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

  static showProgressIndicator(BuildContext context) async {
    AlertDialog alertDialog = const AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.deepOrange),
        ),
      ),
    );
    await showDialog(
      barrierColor: Colors.white.withOpacity(0),
      barrierDismissible: false,
      context: context,
      builder: (context) => alertDialog,
    );
  }

  static Future<void> warningDialog(BuildContext context,
      {required String content,
      required String title,
      required Function() onTap,
      bool? showIcon = false}) async {
    // final size = Utils(context).screenSize;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(title),
              showIcon! ? const Icon(Icons.logout) : Container(),
            ],
          ),
          content: CustomText(content),
          actions: [
            CustomTextButton(
              text: 'لا',
              colorButton: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CustomTextButton(
              text: 'نعم',
              onPressed: onTap,
              colorButton: Colors.white,
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

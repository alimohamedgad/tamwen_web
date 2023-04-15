// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tamwen_web/Featurs/View/Widgets/Custom_Text/custom_text.dart';

import '../../../../Core/AppColors/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  final double? hight;
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color = AppColors.black,
    this.hight = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: hight?.toInt().h,
        margin: const EdgeInsets.all(5),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColors.deepOrange
            // gradient: LinearGradient(
            //   colors: [
            //     color!,
            //     Colors.black,
            //   ],
            // ),
            ),
        child: Center(
          child: CustomText(
            text,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}

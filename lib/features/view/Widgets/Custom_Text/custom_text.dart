// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Core/AppColors/app_colors.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    Key? key,
    this.textAlign = TextAlign.start,
    this.color = AppColors.black,
    this.fontSize = 16,
    this.onTap,
  }) : super(key: key);

  final String text;
  final Color color;
  final double fontSize;
  final Function()? onTap;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: color,
          fontSize: fontSize.sp,
        ),
      ),
    );
  }
}

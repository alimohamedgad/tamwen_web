// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Core/AppColors/app_colors.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? initialValue;
  final Color? colorIcon;
  final IconData? icon;
  final TextInputType keyBordTyp;
  final VoidCallback? onTap;
  final double? width;
  final double? hight;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Function(String)? onChange;
  // final Function(String?)? onSaved;
  const CustomTextfield({
    Key? key,
    this.controller,
    this.hintText,
    this.initialValue,
    this.colorIcon = AppColors.black,
    this.icon,
    required this.keyBordTyp,
    this.onTap,
    this.width,
    this.hight,
    this.validator,
    this.obscureText = false,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hight,
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        // onSaved: onSaved,
        onChanged: onChange,
        onTap: onTap,
        controller: controller,
        initialValue: initialValue,
        keyboardType: keyBordTyp,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(15),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          errorStyle: TextStyle(fontSize: 12.sp, color: AppColors.red),
          hintStyle: TextStyle(fontSize: 17.sp, color: AppColors.black),
          prefixIcon: Icon(
            icon,
            color: colorIcon,
          ),
          enabledBorder: outlineBordaer(),
          errorBorder: outlineBordaer(),
          focusedBorder: outlineBordaer(),
        ),
      ),
    );
  }
}

OutlineInputBorder outlineBordaer() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: const BorderSide(
        color: AppColors.black,
        width: 1.0,
      ));
}

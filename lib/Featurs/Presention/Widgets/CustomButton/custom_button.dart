// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../Core/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? color;
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.color = AppColors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        margin: const EdgeInsets.all(5),
        width: double.infinity,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}

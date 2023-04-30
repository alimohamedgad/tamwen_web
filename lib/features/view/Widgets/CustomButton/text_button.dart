// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../Custom_Text/custom_text.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color color;
  final Color colorButton;
  const CustomTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
    this.colorButton = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        // minimumSize: Size(70, 0),
        backgroundColor: colorButton,
      ),
      onPressed: onPressed,
      child: CustomText(
        text,
        color: color,
      ),
    );
  }
}

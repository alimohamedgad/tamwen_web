import 'package:flutter/material.dart';

import '../Custom_Text/custom_text.dart';

class CusomtTextButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color color;
  const CusomtTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: CustomText(
        text: text,
        color: color,
      ),
    );
  }
}

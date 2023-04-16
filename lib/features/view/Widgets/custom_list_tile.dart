// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../Core/AppColors/app_colors.dart';
import 'Custom_Text/custom_text.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.text,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: Icon(
        icon,
        color: AppColors.white,
      ),
      onTap: onTap,
    );
  }
}

class CustomListTileImageTrailing extends StatelessWidget {
  const CustomListTileImageTrailing({
    Key? key,
    required this.text,
    required this.image,
    this.onTap,
    this.textColor = AppColors.white,
    this.imageColor = AppColors.white,
  }) : super(key: key);

  final String text;
  final String image;
  final Function()? onTap;
  final Color textColor;
  final Color imageColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: CustomText(
        text,
        color: textColor,
        // style: TextStyle(color: textColor),
      ),
      trailing: Image.asset(
        image,
        color: imageColor,
        height: 24,
      ),
      onTap: onTap,
    );
  }
}

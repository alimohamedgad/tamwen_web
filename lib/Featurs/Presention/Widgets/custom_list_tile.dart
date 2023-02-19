// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../Core/app_colors.dart';

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
  }) : super(key: key);

  final String text;
  final String image;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: Image.asset(
        image,
        color: AppColors.white,
        height: 24,
      ),
      onTap: onTap,
    );
  }
}

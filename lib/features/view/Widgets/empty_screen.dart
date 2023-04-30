// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Core/AppColors/app_colors.dart';
import 'Custom_Text/custom_text.dart';

class EmptyScreen extends StatelessWidget {
  final String? textEmpty;
  const EmptyScreen({
    Key? key,
    this.textEmpty = 'هذه القائمة فارغه !',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 60),
        child: Column(
          children: [
            Image.asset(
              'assets/img/empty.png',
              width: double.infinity,
              height: 250.h,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomText(
              textEmpty!,
              color: AppColors.white,
              fontSize: 30,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tamwen_web/Core/AppColors/app_colors.dart';

import 'Custom_Text/custom_text.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset('name'),
          CustomText(
            'هذه القائمة فارغه',
            color: AppColors.white,
            fontSize: 30,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tamwen_web/Featurs/Core/AppColors/app_colors.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.textColor,
      highlightColor: AppColors.primaryColor,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          width: double.infinity,
          color: AppColors.white,
          height: 80,
        ),
      ),
    );
  }
}

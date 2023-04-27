import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../Core/AppColors/app_colors.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: AppColors.grey,
        highlightColor: AppColors.primaryColor,
        child: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            height: 80.h,
          ),
        ),
      ),
    );
  }
}

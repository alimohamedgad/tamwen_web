import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Core/AppColors/app_colors.dart';
import '../../../../Core/App_String/product_string.dart';
import '../../../Controller/Product_cubit/product_cubit.dart';
import '../../Widgets/Custom_Text/custom_text.dart';

class BottomNavigationBarProduct extends StatelessWidget {
  const BottomNavigationBarProduct({
    Key? key,
    required this.totalPriceForOnePerson,
  }) : super(key: key);

  final int totalPriceForOnePerson;

  @override
  Widget build(BuildContext context) {
    final productCubit = BlocProvider.of<ProductCubit>(context);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      title: Container(
        alignment: Alignment.bottomCenter,
        height: 70.h,
        padding: const EdgeInsets.only(top: 7, right: 7),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: AppColors.white,
              blurRadius: 8,
              blurStyle: BlurStyle.outer,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              "${ProductString.totalPrice}"
              "  ${productCubit.getTotalPrice(productCubit.product)} جنية",
              color: AppColors.white,
            ),
            CustomText(
              "${ProductString.theRemainderOftheTotalPrice}"
              "  ${totalPriceForOnePerson - productCubit.getTotalPrice(productCubit.product)}  جنية",
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}

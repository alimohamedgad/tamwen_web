// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tamwen_web/Featurs/Presention/Screens/Mobile/Widgets/Custom_Text/custom_text.dart';

import '../../../../Core/AppColors/app_colors.dart';
import '../../../../Core/app_strings.dart';
import '../../../../Data/model/details_models.dart';
import '../Widgets/custom_details_image.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.details,
  }) : super(key: key);
  final DetailsModel details;

  @override
  Widget build(BuildContext context) {
    var totalPriceOfQuantityPurchased = details.price * details.quantity;
    return Container(
      height: 145,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: AppColors.white,
              blurRadius: 8,
              blurStyle: BlurStyle.outer,
              spreadRadius: 1,
            ),
          ]),
      child: Row(
        children: [
          CustmeDetailsImage(
            image: details.image ?? 'assets/img/white.jpg',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: "${AppStrings.productName}${details.nameProduct}"),
                CustomText(text: "${AppStrings.price}${details.price}"),
                CustomText(
                    text:
                        "${AppStrings.totalprice}$totalPriceOfQuantityPurchased"),
                CustomText(text: "${AppStrings.amount}${details.quantity}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

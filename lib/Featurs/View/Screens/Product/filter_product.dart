// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tamwen_web/Core/AppColors/app_colors.dart';
import 'package:tamwen_web/Featurs/Model/product.dart';
import 'package:tamwen_web/Featurs/Model/user.dart';
import 'package:tamwen_web/Featurs/View/Screens/Product/update_product.dart';
import 'package:tamwen_web/Featurs/View/Widgets/custom_image.dart';

import '../../../Controller/Product_cubit/product_cubit.dart';
import '../../../../Core/App_String/app_strings.dart';
import '../../../../Core/App_String/product_string.dart';
import '../../../../Core/Services/global_method.dart';
import '../../Widgets/Custom_Text/custom_text.dart';

class FiterProduct extends StatefulWidget {
  final UserModel users;
  const FiterProduct({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  State<FiterProduct> createState() => _FiterProductState();
}

class _FiterProductState extends State<FiterProduct> {
  @override
  void initState() {
    ProductCubit.get(context).getProduct(widget.users);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final productCubit = ProductCubit.get(context);
        final filterList = productCubit.product
            .where((element) => element.dateTime == productCubit.maxPrice)
            .toList();
        return Scaffold(
            appBar: AppBar(),
            body: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  Slider(
                    label: ' شهر ${productCubit.maxPrice.round()}',
                    activeColor: Colors.white,
                    min: 0.0,
                    divisions: 12,
                    max: 12,
                    onChanged: (newRating) {
                      setState(() => productCubit.maxPrice = newRating);
                    },
                    value: productCubit.maxPrice,
                  ),
                  Container(
                    width: double.infinity,
                    height: hight * 0.065,
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(' ${AppStrings.name}  ${widget.users.name}'),
                        CustomText('شهر ${productCubit.maxPrice.round()}'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filterList.length,
                      itemBuilder: (context, index) {
                        final details = filterList[index];
                        final totalPriceOfQuantityPurchased =
                            details.price * details.quantity;
                        return Slidable(
                          key: UniqueKey(),
                          startActionPane: ActionPane(
                            extentRatio: 0.50,
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  productCubit.deleteProduct(
                                      widget.users.id!, details);
                                },
                                backgroundColor: const Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: AppStrings.remove,
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  GlobalMethods.navTo(
                                      UpdateProduct(
                                          idUser: widget.users.id,
                                          details: details,
                                          productCubit: productCubit),
                                      context);
                                },
                                backgroundColor: AppColors.black,
                                foregroundColor: Colors.white,
                                icon: Icons.edit_outlined,
                                label: AppStrings.edit,
                              ),
                            ],
                          ),
                          child: Container(
                            height: 145.h,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 7),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 8,
                                    blurStyle: BlurStyle.outer,
                                    spreadRadius: 1,
                                  ),
                                ]),
                            child: Row(
                              children: [
                                CustmeImage(
                                  image:
                                      details.image ?? 'assets/img/white.jpg',
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          "${ProductString.productName}${details.nameProduct}"),
                                      CustomText(
                                          "${AppStrings.price}${details.price}"),
                                      CustomText(
                                          "${AppStrings.totalprice}$totalPriceOfQuantityPurchased"),
                                      CustomText(
                                          "${AppStrings.amount}${details.quantity}"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}

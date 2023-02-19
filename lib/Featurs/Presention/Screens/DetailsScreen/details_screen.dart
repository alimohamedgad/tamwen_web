// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tamwen_web/Featurs/Core/app_colors.dart';
import 'package:tamwen_web/Featurs/Data/model/user_model.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/Product_cubit/product_cubit.dart';
import 'package:tamwen_web/Featurs/Presention/Screens/DetailsScreen/update_product.dart';

import '../../../Core/app_strings.dart';
import '../../../Core/enums.dart';
import '../../Widgets/Custom_Text/custom_text.dart';
import '../../Widgets/navigator.dart';
import '../DrawerScreen/FlourScreen/add_flour.dart';
import 'add_product.dart';
import 'cart_details_screen.dart';

class DetailsScreen extends StatefulWidget {
  final UserModel? users;
  final int? totalPrice;
  const DetailsScreen({
    Key? key,
    this.users,
    this.totalPrice,
  }) : super(key: key);

  static const String idRouter = 'DetailsScreen';

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductCubit>(context).getAllProducts(widget.users!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final totalPriceForOnePerson = widget.totalPrice! +
        widget.users!.priceOfExtraPerople * widget.users!.numberOfExtraPeople;

    final hight = MediaQuery.of(context).size.height;

    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {},
      builder: (context, state) {
        var productCubit = BlocProvider.of<ProductCubit>(context);
        return Scaffold(
            appBar: detailsScreenAppbar(
              context,
              widget.users!,
              widget.totalPrice ?? 0,
            ),
            bottomNavigationBar: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              title: Container(
                alignment: Alignment.bottomCenter,
                height: 80,
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
                      text: "${AppStrings.totalPrice}"
                          "  ${productCubit.getTotalPrice(productCubit.details)} جنية",
                      color: AppColors.white,
                    ),
                    // Text(
                    //   "${AppStrings.totalPriceForOnePerson}"
                    //   " $totalPriceForOnePerson جنية",
                    //   style: const TextStyle(
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.black),
                    // ),
                    CustomText(
                      text: "${AppStrings.theRemainderOftheTotalPrice}"
                          "  ${totalPriceForOnePerson - productCubit.getTotalPrice(productCubit.details)}  جنية",
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),
            ),
            body: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: hight * 0.065,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              text:
                                  ' ${AppStrings.name}  ${widget.users!.name}'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: productCubit.details.length,
                          itemBuilder: (context, index) {
                            var details = productCubit.details[index];
                            return Slidable(
                              key: UniqueKey(),
                              startActionPane: ActionPane(
                                extentRatio: 0.50,
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      productCubit.deleteProduct(
                                          widget.users!.id!,
                                          details.id!,
                                          details);
                                    },
                                    backgroundColor: const Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: AppStrings.remove,
                                  ),
                                  SlidableAction(
                                    onPressed: (context) {
                                      customNavPush(
                                          UpdateProduct(
                                              idUser: widget.users!.id,
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
                              child: CartItem(
                                details: details,
                              ),
                            );
                          }),
                    ),
                  ],
                )));
      },
    );
  }

  AppBar detailsScreenAppbar(
      BuildContext context, UserModel item, int totalPrice) {
    return AppBar(
      leading: const BackButton(),
      elevation: 0.0,
      centerTitle: true,
      title: Text(
          "${totalPrice + item.priceOfExtraPerople * item.numberOfExtraPeople}"),
      actions: [
        PopupMenuButton<PopMenuValue>(
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: PopMenuValue.addNewProduct,
              child: CustomText(
                text: 'أضافة منتج جديد',
              ),
            ),
            const PopupMenuItem(
              value: PopMenuValue.addFlour,
              child: CustomText(
                text: 'أضافة دقيق ',
              ),
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case PopMenuValue.addNewProduct:
                customNavPush(AddProduct(idUser: item.id), context);
                break;
              case PopMenuValue.addFlour:
                customNavPush(AddFlourScreen(users: item), context);
                break;
            }
          },
        ),
      ],
    );
  }
}

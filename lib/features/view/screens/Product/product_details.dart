// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tamwen_web/Core/AppColors/app_colors.dart';
import 'package:tamwen_web/Core/Services/global_method.dart';
import 'package:tamwen_web/Core/Services/utils.dart';
import 'package:tamwen_web/features/View/Screens/Product/update_product.dart';
import 'package:tamwen_web/features/view/Widgets/custom_image.dart';

import '../../../Controller/Product_cubit/product_cubit.dart';
import '../../../../Core/App_String/app_strings.dart';
import '../../../../Core/App_String/product_string.dart';
import '../../../../Core/Services/enums.dart';
import '../../../model/user.dart';
import '../../Widgets/Custom_Text/custom_text.dart';
import '../Drawer/FlourScreen/add_flour.dart';
import 'add_product.dart';
import 'filter_product.dart';

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
    BlocProvider.of<ProductCubit>(context).getProduct(widget.users!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = Utils(context).screenSize.height;
    int totalPriceForOnePerson = getTotalPrice();

    return Scaffold(
      appBar: detailsAppbar(
        context,
        widget.users!,
        widget.totalPrice ?? 0,
      ),
      bottomNavigationBar:
          BottomNavigationBar(totalPriceForOnePerson: totalPriceForOnePerson),
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
              height: screenSize * 0.065,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(' ${AppStrings.name}  ${widget.users?.name}'),
                  CustomText('شهر :${DateTime.now().month}'),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  final productCubit = BlocProvider.of<ProductCubit>(context);

                  return ListView.builder(
                    itemCount: productCubit.product.length,
                    itemBuilder: (context, index) {
                      var details = productCubit.product[index];
                      var totalPriceOfQuantityPurchased =
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
                                    widget.users!.id!, details);
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
                                        idUser: widget.users?.id,
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
                            ],
                          ),
                          child: Row(
                            children: [
                              CustomImage(
                                image: details.image ?? 'assets/img/white.jpg',
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 4),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        "${ProductString.productName}${details.nameProduct}"),
                                    CustomText(
                                        "${AppStrings.price}${details.price}"),
                                    CustomText(
                                        "${AppStrings.totalprice}$totalPriceOfQuantityPurchased"),
                                    CustomText(
                                        "${AppStrings.amount}${(details.quantity).toInt()}"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  int getTotalPrice() {
    final totalPriceForOnePerson = widget.totalPrice! +
        widget.users!.price * widget.users!.numberOfExtraPeople;
    return totalPriceForOnePerson;
  }

  AppBar detailsAppbar(
    BuildContext context,
    UserModel item,
    int totalPrice,
  ) {
    return AppBar(
      leading: const BackButton(),
      elevation: 0.0,
      centerTitle: true,
      title: Text("${totalPrice + item.price * item.numberOfExtraPeople}"),
      actions: [
        PopupMenuButton<PopMenuValue>(
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: PopMenuValue.addNewProduct,
              child: CustomText(
                'أضافة منتج جديد',
              ),
            ),
            const PopupMenuItem(
              value: PopMenuValue.addFlour,
              child: CustomText(
                'أضافة دقيق ',
              ),
            ),
            const PopupMenuItem(
              value: PopMenuValue.month,
              child: CustomText(
                'الشهر ',
              ),
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case PopMenuValue.addNewProduct:
                GlobalMethods.navTo(AddProduct(idUser: item.id), context);
                break;
              case PopMenuValue.addFlour:
                GlobalMethods.navTo(AddFlourScreen(users: item), context);
                break;

              case PopMenuValue.month:
                GlobalMethods.navTo(FiterProduct(users: item), context);
                break;
            }
          },
        ),
      ],
    );
  }
}

class BottomNavigationBar extends StatelessWidget {
  const BottomNavigationBar({
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

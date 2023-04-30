// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamwen_web/Core/Services/global_method.dart';

import '../../../../Core/AppColors/app_colors.dart';
import '../../../../Core/App_String/app_strings.dart';
import '../../../../Core/App_String/product_string.dart';
import '../../../../Core/Services/utils.dart';
import '../../../../Core/dumy_data.dart';
import '../../../Controller/Product_cubit/product_cubit.dart';
import '../../../Model/product.dart';
import '../../../controller/client_cubit/client_cubit.dart';
import '../../Widgets/CustomButton/custom_button.dart';
import '../../Widgets/CustomDropDown/custom_drop_button.dart';
import '../../Widgets/Custom_Text/custom_text.dart';
import '../../Widgets/custom_text_field.dart';

class AddProduct extends StatefulWidget {
  final String? idUser;

  const AddProduct({
    Key? key,
    this.idUser,
  }) : super(key: key);

  static const String idRout = 'AddNewDataInCart';

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final priceProductController = TextEditingController();
  final GlobalKey<FormFieldState> nameProductKey = GlobalKey();
  final GlobalKey<FormFieldState> imageProductKey = GlobalKey();
  final GlobalKey<FormFieldState> quantityProductKey = GlobalKey();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    priceProductController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = ClientCubit.get(context);
    final productCubit = BlocProvider.of<ProductCubit>(context);

    return BlocListener<ProductCubit, ProductState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is ProductAddLoading) {
          GlobalMethods.showProgressIndicator(context);
        }
        if (state is ProductAddSuccess) {
          Navigator.pop(context);
          Utils.snackBar('لقد قمت ب أضافة منتح جديد', AppColors.green);
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  CustomDropDownField(
                    keyDropDown: nameProductKey,
                    selectValue: cubit.selectedProductName,
                    hint: ProductString.choiceNameProduct,
                    items: dumyProduct.map((e) {
                      return DropdownMenuItem(
                        value: e.nameProduct,
                        child: CustomText(
                          e.nameProduct!,
                        ),
                      );
                    }).toList(),
                    onChange: (value) {
                      cubit.selectedProductName = value.toString();
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'يرجي اختيار اسم المنتج';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomDropDownField(
                    keyDropDown: imageProductKey,
                    selectValue: cubit.selectedImage,
                    hint: ProductString.choiceProductImage,
                    items: imageWithNameProductList.map((e) {
                      return DropdownMenuItem(
                        value: e.image,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              e.nameProduct.toString(),
                              color: Colors.black,
                            ),
                            Image.asset(
                              e.image.toString(),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChange: (value) {
                      cubit.selectedImage = value.toString();
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomDropDownField(
                    selectValue: cubit.selectedQuantite,
                    keyDropDown: quantityProductKey,
                    hint: ProductString.choiceQuantity,
                    items: quantityList.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: CustomText(
                          e.toString(),
                        ),
                      );
                    }).toList(),
                    onChange: (value) {
                      cubit.selectedQuantite = value;
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'يرجي اختيار كمية المنتج';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextfield(
                    colorIcon: Colors.deepOrange,
                    icon: Icons.money,
                    controller: priceProductController,
                    keyBordTyp: TextInputType.number,
                    hintText: AppStrings.price,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'يرجى ادخال سعر المنتج';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    onPressed: () async {
                      GlobalMethods.showProgressIndicator(context);
                      addProduct(productCubit, cubit);
                      Navigator.pop(context);
                    },
                    text: ProductString.addProduct,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addProduct(ProductCubit productCubit, ClientCubit cubit) async {
    if (formKey.currentState!.validate()) {
      await productCubit.addProduct(
        ProductModel(
          nameProduct: cubit.selectedProductName,
          image: cubit.selectedImage,
          price: double.parse(priceProductController.text),
          quantity: double.parse(cubit.selectedQuantite.toString()),
          dateTime: DateTime.now().month,
        ),
        widget.idUser!,
      );

      priceProductController.clear();
      nameProductKey.currentState!.reset();
      imageProductKey.currentState!.reset();
      quantityProductKey.currentState!.reset();
    }
  }
}

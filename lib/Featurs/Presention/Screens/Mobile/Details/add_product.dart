// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/People_Cubit/people_state.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/Product_cubit/product_cubit.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/People_Cubit/people_cubit.dart';
import 'package:tamwen_web/Featurs/Presention/Screens/Mobile/Widgets/CustomButton/custom_button.dart';
import 'package:tamwen_web/Featurs/Presention/Screens/Mobile/Widgets/CustomDropDown/custom_drop_button.dart';
import 'package:tamwen_web/Featurs/Presention/Screens/Mobile/Widgets/Custom_Text/custom_text.dart';

import '../../../../Core/App_String/strings.dart';
import '../../../../Core/app_strings.dart';
import '../../../../Data/model/details_models.dart';
import '../Widgets/custom_text_field.dart';

class AddProduct extends StatelessWidget {
  final String? idUser;

  const AddProduct({
    Key? key,
    this.idUser,
  }) : super(key: key);

  static const String idRout = 'AddNewDataInCart';

  @override
  Widget build(BuildContext context) {
    var priceProductContoller = TextEditingController();
    final GlobalKey<FormFieldState> nameProductKey =
        GlobalKey<FormFieldState>();
    final GlobalKey<FormFieldState> imageProductKey =
        GlobalKey<FormFieldState>();
    final GlobalKey<FormFieldState> quantiteProductKey =
        GlobalKey<FormFieldState>();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BlocBuilder<PeopleCubit, PeopleState>(
      builder: (context, state) {
        var cubit = PeopleCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomDropDownField(
                      keyDropDown: nameProductKey,
                      selectVaule: cubit.selectedProductName,
                      hint: AppStrings.choiceNameProduct,
                      items: cubit.nameProductList.map((e) {
                        return DropdownMenuItem(
                          value: e.nameProduct,
                          child: CustomText(
                            text: e.nameProduct!,
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
                      selectVaule: cubit.selectedImage,
                      hint: AppStrings.choiceProductImage,
                      items: imageWithNameProductList.map((e) {
                        return DropdownMenuItem(
                          value: e.image,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: e.nameProduct.toString(),
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
                      selectVaule: cubit.selectedQuantite,
                      keyDropDown: quantiteProductKey,
                      hint: AppStrings.choiceQuantite,
                      items: quantiteList.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: CustomText(
                            text: e.toString(),
                          ),
                        );
                      }).toList(),
                      onChange: (value) {
                        cubit.selectedQuantite = value as int;
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
                      controller: priceProductContoller,
                      keyBordTyp: TextInputType.number,
                      hintText: AppStrings.price,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يرجى ادخال سعر المنتج';
                        }
                        return null;
                      },
                    ),
                    BlocBuilder<ProductCubit, ProductState>(
                      builder: (context, state) {
                        var productCubit =
                            BlocProvider.of<ProductCubit>(context);
                        return CustomButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              productCubit.addProduct(
                                DetailsModel(
                                    nameProduct: cubit.selectedProductName,
                                    image: cubit.selectedImage,
                                    price: double.parse(
                                        priceProductContoller.text),
                                    quantity: cubit.selectedQuantite!,
                                    dateTime: DateTime.now().month),
                                idUser!,
                              );
                              priceProductContoller.clear();
                              nameProductKey.currentState!.reset();
                              imageProductKey.currentState!.reset();
                              quantiteProductKey.currentState!.reset();
                              Navigator.pop(context);
                            }
                          },
                          text: AppStrings.addProduct,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

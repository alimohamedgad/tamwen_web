// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamwen_web/Core/App_String/strings.dart';
import 'package:tamwen_web/Featurs/View/Widgets/CustomButton/custom_button.dart';
import 'package:tamwen_web/Featurs/View/Widgets/CustomDropDown/custom_drop_button.dart';
import 'package:tamwen_web/Featurs/View/Widgets/Custom_Text/custom_text.dart';

import '../../../Controller/People_Cubit/people_cubit.dart';
import '../../../Controller/Product_cubit/product_cubit.dart';
import '../../../../Core/App_String/app_strings.dart';
import '../../../../Core/App_String/product_string.dart';
import '../../../Model/product.dart';
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
  var priceProductContoller = TextEditingController();
  final GlobalKey<FormFieldState> nameProductKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> imageProductKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> quantiteProductKey =
      GlobalKey<FormFieldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    priceProductContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        var cubit = PeopleCubit.get(context);
        var productCubit = BlocProvider.of<ProductCubit>(context);
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
                      hint: ProductString.choiceNameProduct,
                      items: dumyProduct.map((e) {
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
                      hint: ProductString.choiceProductImage,
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
                      hint: ProductString.choiceQuantite,
                      items: quantiteList.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: CustomText(
                            text: e.toString(),
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
                    const SizedBox(height: 10),
                    CustomButton(
                      onPressed: () {
                        addProduct(
                            formKey,
                            productCubit,
                            cubit,
                            priceProductContoller,
                            nameProductKey,
                            imageProductKey,
                            quantiteProductKey,
                            context);
                      },
                      text: ProductString.addProduct,
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

  void addProduct(
      GlobalKey<FormState> formKey,
      ProductCubit productCubit,
      PeopleCubit cubit,
      TextEditingController priceProductContoller,
      GlobalKey<FormFieldState<dynamic>> nameProductKey,
      GlobalKey<FormFieldState<dynamic>> imageProductKey,
      GlobalKey<FormFieldState<dynamic>> quantiteProductKey,
      BuildContext context) {
    if (formKey.currentState!.validate()) {
      productCubit.addProduct(
        ProductModel(
            nameProduct: cubit.selectedProductName,
            image: cubit.selectedImage,
            price: double.parse(priceProductContoller.text),
            quantity: double.parse(cubit.selectedQuantite.toString()),
            dateTime: DateTime.now().month),
        widget.idUser!,
      );
      priceProductContoller.clear();
      nameProductKey.currentState!.reset();
      imageProductKey.currentState!.reset();
      quantiteProductKey.currentState!.reset();
      Navigator.pop(context);
    }
  }
}

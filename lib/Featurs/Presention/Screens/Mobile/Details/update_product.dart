// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamwen_web/Featurs/Core/app_strings.dart';
import 'package:tamwen_web/Featurs/Data/model/details_models.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/Product_cubit/product_cubit.dart';

import '../../../Cubits/Tamwen_Cubit/tamwen_cubit.dart';
import '../Widgets/CustomButton/custom_button.dart';
import '../Widgets/CustomDropDown/custom_drop_button.dart';
import '../Widgets/Custom_Text/custom_text.dart';
import '../Widgets/custom_text_field.dart';

class UpdateProduct extends StatefulWidget {
  final String? idUser;
  final DetailsModel details;
  final ProductCubit productCubit;

  const UpdateProduct({
    Key? key,
    this.idUser,
    required this.details,
    required this.productCubit,
  }) : super(key: key);

  static const String idRout = 'AddNewDataInCart';

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
  TextEditingController? _priceProductContoller;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    TamwenCubit.get(context).selectedProductName = widget.details.nameProduct;
    _priceProductContoller =
        TextEditingController(text: "${widget.details.price}");
    TamwenCubit.get(context).selectedQuantite = widget.details.quantity;
    TamwenCubit.get(context).selectedImage = widget.details.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TamwenCubit, TamwenState>(
      builder: (context, state) {
        var cubit = TamwenCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            leading: const BackButton(),
          ),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomDropDownField(
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
                    ),
                    const SizedBox(height: 10),
                    CustomDropDownField(
                      // keyDropDown: imageProductKey,
                      validator: (value) {
                        if (value == null) {
                          return 'يرجي اختيار صورة المنتج';
                        }
                        return null;
                      },
                      selectVaule: cubit.selectedImage,
                      hint: AppStrings.choiceProductImage,
                      items: cubit.imageWithNameProductList.map((e) {
                        return DropdownMenuItem(
                          value: e.image,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: e.nameProduct.toString(),
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
                      hint: AppStrings.choiceQuantite,
                      items: cubit.quantiteList.map((e) {
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
                    ),
                    const SizedBox(height: 10),
                    CustomTextfield(
                      colorIcon: Colors.deepOrange,
                      icon: Icons.money,
                      controller: _priceProductContoller,
                      keyBordTyp: TextInputType.number,
                      hintText: AppStrings.price,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يرجى ادخال سعر المنتج الجديد';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          widget.productCubit
                              .updateProduct(
                            DetailsModel(
                              id: widget.details.id,
                              nameProduct: cubit.selectedProductName,
                              price: double.parse(_priceProductContoller!.text),
                              quantity: cubit.selectedQuantite!,
                              image: cubit.selectedImage,
                            ),
                            widget.idUser!,
                          )
                              .then((value) {
                            Navigator.pop(context);
                          });
                        }
                      },
                      text: AppStrings.editProduct,
                    )
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

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tamwen_web/Core/App_String/app_strings.dart';

import '../../../../Core/dumy_data.dart';
import '../../../Controller/People_Cubit/client_cubit.dart';
import '../../../../Core/App_String/product_string.dart';
import '../../../Controller/Product_cubit/product_cubit.dart';
import '../../../Model/product.dart';
import '../../Widgets/CustomButton/custom_button.dart';
import '../../Widgets/CustomDropDown/custom_drop_button.dart';
import '../../Widgets/Custom_Text/custom_text.dart';
import '../../Widgets/custom_text_field.dart';

class UpdateProduct extends StatefulWidget {
  final String? idUser;
  final ProductModel details;
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
    ClientCubit.get(context).selectedProductName = widget.details.nameProduct;
    _priceProductContoller =
        TextEditingController(text: "${widget.details.price}");
    ClientCubit.get(context).selectedQuantite = widget.details.quantity;
    ClientCubit.get(context).selectedImage = widget.details.image;
    super.initState();
  }

  @override
  void dispose() {
    _priceProductContoller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = ClientCubit.get(context);

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
                  hint: ProductString.choiceProductImage,
                  items: imageWithNameProductList.map((e) {
                    return DropdownMenuItem(
                      value: e.image,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            e.nameProduct.toString(),
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
                  hint: ProductString.choiceQuantite,
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
                    updateProduct(cubit, context);
                  },
                  text: ProductString.editProduct,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateProduct(ClientCubit cubit, BuildContext context) {
    if (formKey.currentState!.validate()) {
      widget.productCubit
          .updateProduct(
        ProductModel(
            id: widget.details.id,
            nameProduct: cubit.selectedProductName,
            price: double.parse(_priceProductContoller!.text),
            quantity: double.parse(cubit.selectedQuantite.toString()),
            image: cubit.selectedImage,
            dateTime: DateTime.now().month),
        widget.idUser!,
      )
          .then((value) {
        Navigator.pop(context);
      });
    }
  }
}

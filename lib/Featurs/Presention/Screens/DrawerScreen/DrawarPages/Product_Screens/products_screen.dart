// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamwen_web/Featurs/Data/model/user_model.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/Product_cubit/product_cubit.dart';
import 'package:tamwen_web/Featurs/Presention/Widgets/Custom_Text/custom_text.dart';

import '../../../../../Data/model/details_models.dart';

class ProductsScreen extends StatefulWidget {
  final List<UserModel> userModel;
  const ProductsScreen({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    // var model = widget.userModel.map((e) => e).toList();
    BlocProvider.of<ProductCubit>(context).getAllProducts2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              var productCubit = BlocProvider.of<ProductCubit>(context);
              // BlocProvider.of<ProductCubit>(context).getAllProducts(user);

              return Expanded(
                child: ListView.builder(
                  itemCount: productCubit.details.length,
                  itemBuilder: (context, index) {
                    var product = productCubit.details[index];
                    return Card(
                      child: ListTile(
                        title: CustomText(text: '${product.nameProduct}'),
                        trailing: CustomText(
                          text: '${getTotlaProducts(productCubit.details)}',
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }

  getTotlaProducts(List<DetailsModel> detailsList) {
    double totalPrice = 0.0;
    for (var element
        in detailsList.where((element) => element.nameProduct == 'سكر تموين')) {
      totalPrice += element.quantity;
    }
    return totalPrice.toInt();
  }
}

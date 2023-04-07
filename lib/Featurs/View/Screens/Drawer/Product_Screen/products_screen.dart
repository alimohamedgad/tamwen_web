// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamwen_web/Featurs/Controller/Product_cubit/product_cubit.dart';
import 'package:tamwen_web/Featurs/Model/user.dart';
import 'package:tamwen_web/Featurs/View/Widgets/Custom_Text/custom_text.dart';

import '../../../../Model/product.dart';

class ProductsScreen extends StatefulWidget {
  final UserModel userModel;
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
    BlocProvider.of<ProductCubit>(context).getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          var productCubit = BlocProvider.of<ProductCubit>(context);
          final filteredClassList = productCubit.productFilter
              .fold<Map<String, ProductModel>>({}, (map, product) {
                map.putIfAbsent(product.nameProduct!, () => product);
                return map;
              })
              .values
              .toList();

          return ListView.builder(
            itemCount: filteredClassList.length,
            itemBuilder: (context, index) {
              var product = filteredClassList[index];
              return Card(
                child: ListTile(
                  title: CustomText(text: '${product.nameProduct}'),
                  leading: Image.asset(
                    '${product.image}',
                    height: 30.h,
                  ),
                  trailing: CustomText(
                    text:
                        '${getTotlaProducts(productCubit.productFilter, product.nameProduct!)}',
                  ),
                  // trailing: CustomText(
                  //   text: '${product.quantity}',
                  // ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  getTotlaProducts(List<ProductModel> detailsList, String nameProduct) {
    double totalPrice = 0.0;
    for (var product
        in detailsList.where((element) => element.nameProduct == nameProduct)) {
      totalPrice += product.quantity;
    }

    return totalPrice.toInt();
  }
}


  //* var seen = Set<String>();
  //*   List<String> uniquelist = countries.where((country) => seen.add(country)).toList();


     //* groupData
          // *   .map((dynamic item) => GetOrder.fromJson(item))
          // *    .fold<Map<String, GetOrder>>({}, (map, element) {
          //*       map.putIfAbsent(element.orderId, () => element);
          //   *    return map;
          //  *   })
          // *    .values
          //*     .toList();
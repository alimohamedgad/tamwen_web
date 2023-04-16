// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:tamwen_web/Core/AppColors/app_colors.dart';
import 'package:tamwen_web/Core/App_String/app_strings.dart';
import 'package:tamwen_web/Core/Services/global_method.dart';

import '../../../../features/Model/user.dart';
import '../../../Controller/People_Cubit/client_cubit.dart';
import '../../Screens/Home/update_client.dart';
import '../../screens/Product/product_details.dart';
import '../Custom_Text/custom_text.dart';
import '../total_price_for_persons.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
    required this.users,
    required this.clientCubit,
  }) : super(key: key);

  final List<UserModel> users;
  final ClientCubit clientCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AnimationLimiter(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                var mainPrice = user.numberOfMainPeople;
                var totlePrice = 0;
                totlePrice = totalPriceForMainPersons(mainPrice, totlePrice);
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 600),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Slidable(
                        key: UniqueKey(),
                        startActionPane: ActionPane(
                          extentRatio: 0.50,
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) async {
                                await clientCubit.deleteUser(user);
                              },
                              backgroundColor: const Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: AppStrings.remove,
                            ),
                            SizedBox(width: 4.w),
                            SlidableAction(
                              onPressed: (context) {
                                GlobalMethods.navTo(
                                    UpdateUser(users: user), context);
                              },
                              backgroundColor: AppColors.black,
                              foregroundColor: Colors.white,
                              icon: Icons.edit_outlined,
                              label: AppStrings.edit,
                            ),
                          ],
                        ),
                        child: Card(
                          margin: const EdgeInsets.all(5),
                          color: AppColors.white,
                          shadowColor: Colors.black,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              width: 0.5.w,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: ListTile(
                            onTap: () {
                              GlobalMethods.navTo(
                                DetailsScreen(
                                  users: users[index],
                                  totalPrice: totlePrice,
                                ),
                                context,
                              );
                            },
                            title: CustomText(
                              "${AppStrings.name}${user.name}",
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  "${AppStrings.numberOfIndividuals}${user.numberOfMainPeople}  /  ${user.numberOfExtraPeople}",
                                ),
                                CustomText(
                                  "${AppStrings.password} ${user.password}",
                                ),
                              ],
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomText(totlePrice.toString()),
                                const Spacer(),
                                CustomText(
                                  "${user.priceOfExtraPerople * user.numberOfExtraPeople}",
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}



// Container(
//                       margin: EdgeInsets.all(4),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Container(
//                         width: 70,
//                         decoration: BoxDecoration(),
//                         child: Center(
//                           child: InkWell(
//                               onTap: () {
//                                 setState(() {
//                                   text = product.name;
//                                 });
//                               },
//                               child: Text(
//                                   'شهر ${product.numberOfMainPeople.toString()}')),
//                         ),
//                       ),
//                     ),

// void getDeferenetUsers(List<UserModel> filterList, Object? number) {
//   filterList.where((userFilter) => userFilter.numberOfMainPeople == number).toList();
// }
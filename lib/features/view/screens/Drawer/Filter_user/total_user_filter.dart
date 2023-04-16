// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:tamwen_web/Core/App_String/app_strings.dart';
import 'package:tamwen_web/Core/Services/global_method.dart';

import '../../../../../Core/AppColors/app_colors.dart';
import '../../../../Controller/People_Cubit/client_cubit.dart';
import '../../../../Controller/People_Cubit/people_state.dart';
import '../../../Widgets/Custom_Text/custom_text.dart';
import '../../../Widgets/total_price_for_persons.dart';
import '../../Home/update_client.dart';
import '../../Product/product_details.dart';

class TotalPeopeEqualOne extends StatefulWidget {
  final Object isEqualTo;

  const TotalPeopeEqualOne({
    Key? key,
    required this.isEqualTo,
  }) : super(key: key);

  @override
  State<TotalPeopeEqualOne> createState() => _TotalPeopeEqualOneState();
}

class _TotalPeopeEqualOneState extends State<TotalPeopeEqualOne> {
  @override
  void initState() {
    ClientCubit.get(context).getDifferentUser(widget.isEqualTo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ConditionalBuilder(
        condition: ClientCubit.get(context).differentUser.isNotEmpty,
        fallback: (context) => const Center(
          child: CustomText(
            AppStrings.thisListIsEmpty,
            color: AppColors.white,
            fontSize: 25,
          ),
        ),
        builder: (BuildContext context) {
          return BlocBuilder<ClientCubit, ClientState>(
            builder: (context, state) {
              var clientCubit = ClientCubit.get(context);

              return AnimationLimiter(
                child: ListView.builder(
                  itemCount: clientCubit.differentUser.length,
                  itemBuilder: (context, index) {
                    final user = clientCubit.differentUser[index];
                    var mainPrice = user.numberOfMainPeople;
                    var totlePrice = 0;
                    totlePrice =
                        totalPriceForMainPersons(mainPrice, totlePrice);
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
                                const SizedBox(width: 4),
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
                            child: InkWell(
                              onTap: () {
                                GlobalMethods.navTo(
                                  DetailsScreen(
                                    users: clientCubit.differentUser[index],
                                    totalPrice: totlePrice,
                                  ),
                                  context,
                                );
                              },
                              child: Card(
                                margin: const EdgeInsets.all(5),
                                color: AppColors.textColor,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                    width: 0.5,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                child: ListTile(
                                  title: CustomText(
                                    "${AppStrings.name}${user.name}",
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

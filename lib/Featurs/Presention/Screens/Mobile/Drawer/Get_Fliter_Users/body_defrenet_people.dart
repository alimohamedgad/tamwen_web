// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../../Core/AppColors/app_colors.dart';
import '../../../../../Core/App_String/app_strings.dart';
import '../../../../../Core/Services/global_method.dart';
import '../../../../Cubits/People_Cubit/people_cubit.dart';
import '../../../../Widgets/Custom_Text/custom_text.dart';
import '../../../../Widgets/navigator.dart';
import '../../../../Widgets/total_price_for_persons.dart';
import '../../Product/details_screen.dart';
import '../../Home/update_client.dart';

class BodyScreenForDeferentPeople extends StatefulWidget {
  const BodyScreenForDeferentPeople({
    Key? key,
    this.peopleCubit,
    required this.isEqualTo,
  }) : super(key: key);

  // final List<UserModel> users;
  final PeopleCubit? peopleCubit;
  final Object isEqualTo;

  @override
  State<BodyScreenForDeferentPeople> createState() =>
      _BodyScreenForDeferentPeopleState();
}

class _BodyScreenForDeferentPeopleState
    extends State<BodyScreenForDeferentPeople> {
  @override
  void initState() {
    widget.peopleCubit!.getDifferentUser(widget.isEqualTo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: widget.peopleCubit!.differentUser.isNotEmpty,
      fallback: (context) => const Center(
        child: CustomText(
          text: AppStrings.thisListIsEmpty,
          color: AppColors.white,
          fontSize: 25,
        ),
      ),
      builder: (BuildContext context) {
        return AnimationLimiter(
          child: ListView.builder(
            itemCount: widget.peopleCubit!.differentUser.length,
            itemBuilder: (context, index) {
              final user = widget.peopleCubit!.differentUser[index];
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
                              await widget.peopleCubit!.deleteUser(user);
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
                              users: widget.peopleCubit!.differentUser[index],
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
                              text: "${AppStrings.name}${user.name}",
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text:
                                      "${AppStrings.numberOfIndividuals}${user.numberOfMainPeople}  /  ${user.numberOfExtraPeople}",
                                ),
                                CustomText(
                                  text:
                                      "${AppStrings.password} ${user.password}",
                                ),
                              ],
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomText(text: totlePrice.toString()),
                                const Spacer(),
                                CustomText(
                                  text:
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
  }
}

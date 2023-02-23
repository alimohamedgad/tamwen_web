// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../../Core/AppColors/app_colors.dart';
import '../../../../../Core/app_strings.dart';
import '../../../../Cubits/Tamwen_Cubit/tamwen_cubit.dart';
import '../../Widgets/Custom_Text/custom_text.dart';
import '../../Widgets/navigator.dart';
import '../../Widgets/total_price_for_persons.dart';
import '../../Details/details_screen.dart';
import '../../Home/update_user.dart';

class BodyScreenForDeferentPeople extends StatefulWidget {
  const BodyScreenForDeferentPeople({
    Key? key,
    this.tamwenCubit,
    required this.isEqualTo,
  }) : super(key: key);

  // final List<UserModel> users;
  final TamwenCubit? tamwenCubit;
  final Object isEqualTo;

  @override
  State<BodyScreenForDeferentPeople> createState() =>
      _BodyScreenForDeferentPeopleState();
}

class _BodyScreenForDeferentPeopleState
    extends State<BodyScreenForDeferentPeople> {
  @override
  void initState() {
    widget.tamwenCubit!.getAllUsersForDeferentPerson(widget.isEqualTo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: widget.tamwenCubit!.deferentUserList.isNotEmpty,
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
            itemCount: widget.tamwenCubit!.deferentUserList.length,
            itemBuilder: (context, index) {
              final user = widget.tamwenCubit!.deferentUserList[index];
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
                              await widget.tamwenCubit!.deleteUser(user);
                            },
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: AppStrings.remove,
                          ),
                          const SizedBox(width: 4),
                          SlidableAction(
                            onPressed: (context) {
                              customNavPush(UpdateUser(users: user), context);
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
                          customNavPush(
                            DetailsScreen(
                              users:
                                  widget.tamwenCubit!.deferentUserList[index],
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

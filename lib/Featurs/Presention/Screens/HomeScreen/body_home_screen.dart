// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:tamwen_web/Featurs/Presention/Screens/HomeScreen/update_user.dart';

import '../../../Core/app_colors.dart';
import '../../../Core/app_strings.dart';
import '../../../Data/model/user_model.dart';
import '../../Cubits/Tamwen_Cubit/tamwen_cubit.dart';
import '../../Widgets/Custom_Text/custom_text.dart';
import '../../Widgets/navigator.dart';
import '../../Widgets/total_price_for_persons.dart';
import '../DetailsScreen/details_screen.dart';

class BodyHomeScreen extends StatelessWidget {
  const BodyHomeScreen({
    Key? key,
    required this.users,
    this.cubit,
  }) : super(key: key);

  final List<UserModel> users;
  final TamwenCubit? cubit;

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: users.isNotEmpty,
      fallback: (context) => const Center(
        child: CustomText(
          text: AppStrings.thisListIsEmpty,
          color: AppColors.white,
          fontSize: 25,
        ),
      ),
      builder: (BuildContext context) => AnimationLimiter(
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
                            await cubit!.deleteUser(user);
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
                            users: users[index],
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
                                text: "${AppStrings.password} ${user.password}",
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
      ),
    );
  }
}

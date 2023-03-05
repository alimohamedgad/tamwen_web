// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:tamwen_web/Featurs/Presention/Screens/Web/HomeScreen_Web/update_user_web.dart';

import '../../../../Core/AppColors/app_colors.dart';
import '../../../../Core/app_strings.dart';
import '../../../../Data/model/user_model.dart';
import '../../../Cubits/People_Cubit/people_cubit.dart';
import '../../Mobile/Widgets/Custom_Text/custom_text.dart';
import '../../Mobile/Widgets/Simmer_Loading/shimmer.dart';
import '../../Mobile/Widgets/navigator.dart';
import '../../Mobile/Widgets/total_price_for_persons.dart';
import '../../Mobile/Details/details_screen.dart';
import '../../Mobile/Home/home_page.dart';

class BodyHomeScreenWeb extends StatelessWidget {
  const BodyHomeScreenWeb({
    Key? key,
    required this.users,
    this.peopleCubit,
  }) : super(key: key);

  final List<UserModel> users;
  final PeopleCubit? peopleCubit;

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 10),
        Expanded(
          flex: 7,
          child: ConditionalBuilder(
            condition: users.isNotEmpty,
            fallback: (context) => const ShimmerLoading(),
            builder: (BuildContext context) => Column(
              children: [
                appBarHomePage(context, peopleCubit!),
                Expanded(
                  child: AnimationLimiter(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 3 / 1.7,
                        // crossAxisSpacing: 1,
                        // mainAxisSpacing: 1,
                      ),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        var mainPrice = user.numberOfMainPeople;
                        var totlePrice = 0;
                        totlePrice =
                            totalPriceForMainPersons(mainPrice, totlePrice);
                        return AnimationConfiguration.staggeredGrid(
                          columnCount: users.length,
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
                                        await peopleCubit!.deleteUser(user);
                                      },
                                      backgroundColor: const Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: AppStrings.remove,
                                    ),
                                    SizedBox(width: 4.w),
                                    SlidableAction(
                                      onPressed: (context) {
                                        customNavPush(
                                            UpdateUserWeb(users: user),
                                            context);
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
                                      side: BorderSide(
                                        width: 0.5.w,
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    child: ListTile(
                                      title: CustomText(
                                        text: "${AppStrings.name}${user.name}",
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CustomText(
                                              text: totlePrice.toString()),
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

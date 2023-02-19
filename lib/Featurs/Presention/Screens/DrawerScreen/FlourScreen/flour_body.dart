import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/Flour_Cubit/flour_cubit.dart';
import '../../../../Data/model/flour_model.dart';
import 'update_flour.dart';
import '../../../../Core/app_colors.dart';
import '../../../../Core/app_strings.dart';
import '../../../Widgets/Custom_Text/custom_text.dart';
import '../../../Widgets/navigator.dart';

class BodyFlourScreen extends StatelessWidget {
  const BodyFlourScreen({
    Key? key,
    required this.flourList,
  }) : super(key: key);

  final List<FlourModel> flourList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlourCubit, FlourState>(
      builder: (context, state) {
        var flourCubit = BlocProvider.of<FlourCubit>(context);

        return ConditionalBuilder(
          condition: flourList.isNotEmpty,
          fallback: (context) => const Center(
            child: CustomText(
              text: AppStrings.thisListIsEmpty,
              color: AppColors.white,
              fontSize: 25,
            ),
          ),
          builder: (BuildContext context) => AnimationLimiter(
            child: ListView.builder(
              itemCount: flourList.length,
              itemBuilder: (context, index) {
                final flourItem = flourList[index];
                // var mainPrice = user.numberOfMainPeople;
                // var totlePrice = 0;
                // totlePrice = totalPriceForMainPersons(mainPrice, totlePrice);
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
                                await flourCubit.deleteFlour(flourItem);
                              },
                              backgroundColor: const Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: AppStrings.remove,
                            ),
                            const SizedBox(width: 4),
                            SlidableAction(
                              onPressed: (context) {
                                customNavPush(
                                    UpdateFlour(flourModel: flourItem),
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
                            // customNavPush(
                            //   DetailsScreen(
                            //     users: users[index],
                            //     totalPrice: totlePrice,
                            //   ),
                            //   context,
                            // );
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
                                text:
                                    "${AppStrings.name}${flourItem.nameClient}",
                              ),
                              subtitle: CustomText(
                                text:
                                    "${AppStrings.amountFloat}${flourItem.amountFlour} ك ",
                              ),
                              trailing: CustomText(text: flourItem.round),
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
      },
    );
  }
}

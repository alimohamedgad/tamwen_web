import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../Controller/Flour_Cubit/flour_cubit.dart';
import '../../../../../Core/Services/global_method.dart';
import '../../../../../Core/App_String/product_string.dart';
import '../../../../model/flour.dart';
import 'update_flour.dart';
import '../../../../../Core/AppColors/app_colors.dart';
import '../../../../../Core/App_String/app_strings.dart';
import '../../../Widgets/Custom_Text/custom_text.dart';

class BodyFlourScreen extends StatelessWidget {
  const BodyFlourScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlourCubit, FlourState>(
      builder: (context, state) {
        final flourCubit = BlocProvider.of<FlourCubit>(context);

        return ConditionalBuilder(
          condition: flourCubit.flourList.isNotEmpty,
          fallback: (context) => const Center(
            child: CustomText(
              AppStrings.thisListIsEmpty,
              color: AppColors.white,
              fontSize: 25,
            ),
          ),
          builder: (BuildContext context) => AnimationLimiter(
            child: ListView.builder(
              itemCount: flourCubit.flourList.length,
              itemBuilder: (context, index) {
                final flourItem = flourCubit.flourList[index];
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
                                GlobalMethods.navTo(
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
                                "${AppStrings.name}${flourItem.nameClient}",
                              ),
                              subtitle: CustomText(
                                "${ProductString.amountFloat}${flourItem.amountFlour} ك ",
                              ),
                              trailing: CustomText(flourItem.round),
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

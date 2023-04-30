import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:tamwen_web/features/view/Widgets/CustomButton/text_button.dart';
import '../../../../Controller/Flour_Cubit/flour_cubit.dart';
import '../../../Widgets/empty_screen.dart';

import '../../../../../Core/AppColors/app_colors.dart';
import '../../../../../Core/App_String/app_strings.dart';
import '../../../../../Core/App_String/product_string.dart';
import '../../../../../Core/Services/global_method.dart';
import '../../../Widgets/Custom_Text/custom_text.dart';
import '../../../../Model/flour.dart';
import 'update_flour.dart';

class BodyFlourScreen extends StatelessWidget {
  const BodyFlourScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FlourCubit, FlourState>(
      builder: (context, state) {
        final flourCubit = BlocProvider.of<FlourCubit>(context);

        if (state is GetFlourLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.deepOrange,
            ),
          );
        } else {
          return ConditionalBuilder(
            condition: flourCubit.flourList.isNotEmpty,
            fallback: (context) => const EmptyScreen(),
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
                        child:
                            _buildFlourDetails(flourItem, flourCubit, context),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildFlourDetails(
      FlourModel flourItem, FlourCubit flourCubit, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.white,
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                "${AppStrings.name}${flourItem.nameClient}",
                fontSize: 20,
              ),
              CustomText(
                "${ProductString.amountFloat}${flourItem.amountFlour} ك ",
                fontSize: 20,
              ),
              CustomText(
                flourItem.round,
                fontSize: 20,
              ),
            ],
          ),
          Column(
            children: [
              CustomTextButton(
                text: 'تعديل',
                color: Colors.white,
                colorButton: Colors.green,
                onPressed: () async {
                  GlobalMethods.navTo(
                      UpdateFlour(
                          flourModel: flourItem, flourCubit: flourCubit),
                      context);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextButton(
                text: 'حذف',
                color: Colors.white,
                colorButton: Colors.red,
                onPressed: () async {
                  await GlobalMethods.warningDialog(
                    context,
                    content: 'هل تريد حذف المنتج ؟',
                    title: '',
                    onTap: () async {
                      Navigator.pop(context);
                      await flourCubit.deleteFlour(flourItem);
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

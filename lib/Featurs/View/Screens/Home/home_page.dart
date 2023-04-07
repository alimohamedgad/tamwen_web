import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:tamwen_web/Core/AppColors/app_colors.dart';
import 'package:tamwen_web/Core/App_String/app_strings.dart';
import 'package:tamwen_web/Core/Services/global_method.dart';
import 'package:tamwen_web/Featurs/View/Screens/Home/update_client.dart';
import 'package:tamwen_web/Featurs/View/Screens/Product/details_screen.dart';
import 'package:tamwen_web/Featurs/View/Widgets/Custom_Text/custom_text.dart';
import '../../../Controller/People_Cubit/people_cubit.dart';
import '../../../Controller/People_Cubit/people_state.dart';
import '../../Widgets/Simmer_Loading/shimmer.dart';
import '../../Widgets/total_price_for_persons.dart';
import '../Drawer/drawer_screens.dart';
import '../../Widgets/SearchScreen/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    PeopleCubit.get(context).getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeopleCubit, PeopleState>(
      builder: (context, state) {
        var peopleCubit = PeopleCubit.get(context);

        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0.0,
              actions: [
                IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearch(
                          users: peopleCubit.users, cubit: peopleCubit),
                    );
                  },
                  icon: const Icon(
                    Icons.search,
                  ),
                ),
              ],
            ),
            drawer: DrawerScreen(peopleCubit: peopleCubit),
            body: ConditionalBuilder(
              condition: peopleCubit.users.isNotEmpty,
              fallback: (context) => const ShimmerLoading(),
              builder: (BuildContext context) => Column(
                children: [
                  Expanded(
                    child: AnimationLimiter(
                      child: ListView.builder(
                        itemCount: peopleCubit.users.length,
                        itemBuilder: (context, index) {
                          final user = peopleCubit.users[index];
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
                                          await peopleCubit.deleteUser(user);
                                        },
                                        backgroundColor:
                                            const Color(0xFFFE4A49),
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
                                            users: peopleCubit.users[index],
                                            totalPrice: totlePrice,
                                          ),
                                          context,
                                        );
                                      },
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
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}

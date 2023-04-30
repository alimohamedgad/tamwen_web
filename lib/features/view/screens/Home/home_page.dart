import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../controller/client_cubit/client_cubit.dart';
import '../../../controller/client_cubit/client_state.dart';
import '../../../model/user.dart';
import '../../../../Core/AppColors/app_colors.dart';
import '../../../../Core/App_String/app_strings.dart';
import '../../../../Core/Services/global_method.dart';
import '../../../View/Screens/Home/update_client.dart';
import '../../Widgets/empty_screen.dart';
import '../../Widgets/Custom_Text/custom_text.dart';
import '../../Widgets/Simmer_Loading/shimmer.dart';
import '../../Widgets/total_price_for_persons.dart';
import '../Drawer/drawer_screens.dart';
import '../../Widgets/SearchScreen/search.dart';
import '../Product/product_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<ClientCubit>(context).getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearch(),
              );
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      drawer: const DrawerScreen(),
      body: BlocBuilder<ClientCubit, ClientState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          final clientCubit = ClientCubit.get(context);
          if (state is UsersLoading) {
            return const ShimmerLoading();
          } else {
            return Column(
              children: [
                clientCubit.users.isNotEmpty
                    ? Expanded(
                        child: AnimationLimiter(
                          child: ListView.builder(
                            itemCount: clientCubit.users.length,
                            itemBuilder: (context, index) {
                              UserModel user = clientCubit.users[index];
                              final mainPrice = user.numberOfMainPeople;
                              var totlePrice = 0;
                              totlePrice = totalPriceForMainPersons(
                                  mainPrice, totlePrice);
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 600),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: Slidable(
                                      key: UniqueKey(),
                                      startActionPane: _buildSlidableAction(
                                          clientCubit, user),
                                      child: Card(
                                        margin: const EdgeInsets.all(5),
                                        color: AppColors.white,
                                        shadowColor: Colors.black,
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide(
                                            width: 0.5.w,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                        child: ListTile(
                                          onTap: () {
                                            GlobalMethods.navTo(
                                              DetailsScreen(
                                                users: clientCubit.users[index],
                                                totalPrice: totlePrice,
                                              ),
                                              context,
                                            );
                                          },
                                          title: CustomText(
                                            AppStrings.name + user.name,
                                            textAlign: TextAlign.right,
                                          ),
                                          subtitle: _buildSubTitle(user),
                                          trailing:
                                              _buildTrailing(totlePrice, user),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    : const Expanded(
                        child: EmptyScreen(
                            textEmpty:
                                ' لا يوجد لديك عملاء !\n يرجي أضافة عميل'),
                      ),
              ],
            );
          }
        },
      ),
    );
  }

  ActionPane _buildSlidableAction(ClientCubit clientCubit, UserModel user) {
    return ActionPane(
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
            GlobalMethods.navTo(UpdateUser(users: user), context);
          },
          backgroundColor: AppColors.black,
          foregroundColor: Colors.white,
          icon: Icons.edit_outlined,
          label: AppStrings.edit,
        ),
      ],
    );
  }

  Column _buildTrailing(int totlePrice, UserModel user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(totlePrice.toString()),
        const Spacer(),
        CustomText(
          "${user.price * user.numberOfExtraPeople}",
        ),
      ],
    );
  }

  Column _buildSubTitle(UserModel user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          "${AppStrings.numberOfIndividuals}${user.numberOfMainPeople}  /  ${user.numberOfExtraPeople}",
        ),
        CustomText(
          "${AppStrings.password} ${user.password}",
        ),
      ],
    );
  }
}

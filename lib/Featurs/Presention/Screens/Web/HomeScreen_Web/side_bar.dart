import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamwen_web/Featurs/Presention/Screens/Web/HomeScreen_Web/home_screnn_web.dart';
import 'package:tamwen_web/Featurs/Presention/Screens/Web/HomeScreen_Web/total_card_web.dart';
import 'package:vertical_tabs_flutter/vertical_tabs.dart';

import '../../../../Core/AppColors/app_colors.dart';
import '../../../../Core/app_strings.dart';
import '../../../Cubits/Login_Cubit/login_cubit.dart';
import '../../../Cubits/People_Cubit/people_cubit.dart';
import '../../Mobile/Widgets/custom_list_tile.dart';
import '../../Mobile/Widgets/navigator.dart';
import '../../Mobile/Drawer/FlourScreen/flour_screen.dart';
import '../LoginScreen_Web/login_web.dart';
import 'add_user_web.dart';

class DrawerBodyWeb extends StatelessWidget {
  const DrawerBodyWeb({
    Key? key,
    required this.user,
    required this.peopleCubit,
  }) : super(key: key);

  final User? user;
  final PeopleCubit peopleCubit;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // UserAccountsDrawerHeader(
          //   accountName: const CustomText(
          //     text: 'الحساب الخاص بك',
          //   ),
          //   accountEmail: CustomText(
          //     text: user!.email!,
          //   ),
          //   decoration: const BoxDecoration(color: AppColors.textColor),
          // ),
          CustomListTile(
            icon: Icons.home,
            text: AppStrings.homePage,
            onTap: () {
              customNavReplace(const HomePageWeb(), context);
            },
          ),
          CustomListTile(
            icon: Icons.add_card_sharp,
            text: AppStrings.addNewUser,
            onTap: () {
              customNavPush(const AddUserWeb(), context);
            },
          ),
          CustomListTileImageTrailing(
            image: 'assets/img/flour.png',
            text: AppStrings.amountFlour,
            onTap: () {
              customNavPush(const FlourScreen(), context);
            },
          ),
          CustomListTile(
            icon: Icons.people_alt,
            text: AppStrings.totalPerosns,
            onTap: () {
              customNavPush(TotalCardsWeb(users: peopleCubit.users), context);
            },
          ),
          // CustomListTile(
          //     icon: Icons.production_quantity_limits,
          //     text: AppStrings.products,
          //     onTap: () {
          //       customNavPush(
          //         ProductsScreen(userModel: peopleCubit.users),
          //         context,
          //       );
          //     }),
          CustomListTile(
            icon: Icons.logout_outlined,
            text: AppStrings.signOut,
            onTap: () async {
              var loginCubit = BlocProvider.of<LoginCubit>(context);
              customNavPush(const LoginScreenWeb(), context);
              await loginCubit.signOut();
            },
          ),
        ],
      ),
    );
  }
}

class CustomVerticalTabs extends StatelessWidget {
  const CustomVerticalTabs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black,
              child: VerticalTabs(
                direction: TextDirection.rtl,
                tabsWidth: 80.w,
                tabs: const [
                  Tab(
                    child: CustomListTile(
                      icon: Icons.home,
                      text: AppStrings.homePage,
                    ),
                  ),
                  Tab(
                    child: CustomListTile(
                      icon: Icons.add_card_sharp,
                      text: AppStrings.addNewUser,
                    ),
                  ),
                  Tab(
                    child: CustomListTileImageTrailing(
                      image: 'assets/img/flour.png',
                      text: AppStrings.amountFlour,
                      imageColor: AppColors.black,
                      textColor: AppColors.black,
                    ),
                  ),
                ],
                contents: const [
                  HomePageWeb(),
                  AddUserWeb(),
                  FlourScreen(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    //   children: [
    //     UserAccountsDrawerHeader(
    //       accountName: const CustomText(
    //         text: 'الحساب الخاص بك',
    //       ),
    //       accountEmail: CustomText(
    //         text: user!.email!,
    //       ),
    //       decoration: const BoxDecoration(color: AppColors.textColor),
    //     ),
    //     CustomListTile(
    //       icon: Icons.home,
    //       text: AppStrings.homePage,
    //       onTap: () {
    //         customNavReplace(const HomePageWeb(), context);
    //       },
    //     ),
    //     CustomListTile(
    //       icon: Icons.add_card_sharp,
    //       text: AppStrings.addNewUser,
    //       onTap: () {
    //         customNavPush(const AddUserWeb(), context);
    //       },
    //     ),
    //     CustomListTileImageTrailing(
    //       image: 'assets/img/flour.png',
    //       text: AppStrings.amountFlour,
    //       onTap: () {
    //         customNavPush(const FlourScreen(), context);
    //       },
    //     ),
    //     CustomListTile(
    //       icon: Icons.people_alt,
    //       text: AppStrings.totalPerosns,
    //       onTap: () {
    //         customNavPush(TotalCardsWeb(users: PeopleCubit.users), context);
    //       },
    //     ),
    //     CustomListTile(
    //         icon: Icons.production_quantity_limits,
    //         text: AppStrings.products,
    //         onTap: () {
    //           customNavPush(
    //             ProductsScreen(userModel: PeopleCubit.users),
    //             context,
    //           );
    //         }),
    //     CustomListTile(
    //       icon: Icons.logout_outlined,
    //       text: AppStrings.signOut,
    //       onTap: () async {
    //         var loginCubit = BlocProvider.of<LoginCubit>(context);
    //         customNavPush(const LoginScreenWeb(), context);
    //         await loginCubit.signOut();
    //       },
    //     ),
    //   ],
    // );
  }
}

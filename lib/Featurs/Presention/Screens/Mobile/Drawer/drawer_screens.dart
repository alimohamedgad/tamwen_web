// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamwen_web/Featurs/Presention/Screens/Mobile/Login/login_screen.dart';

import '../../../../Core/AppColors/app_colors.dart';
import '../../../../Core/app_strings.dart';
import '../../../../Data/model/user_model.dart';
import '../../../Cubits/Login_Cubit/login_cubit.dart';
import '../../../Cubits/Tamwen_Cubit/tamwen_cubit.dart';
import '../Widgets/Custom_Text/custom_text.dart';
import '../Widgets/custom_list_tile.dart';
import '../Widgets/navigator.dart';
import '../Home/add_user.dart';
import '../Home/card_screen.dart';
import 'FlourScreen/flour_screen.dart';
import 'Product_Screen/products_screen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({
    Key? key,
    required this.tamwenCubit,
  }) : super(key: key);

  final TamwenCubit tamwenCubit;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: Material(
        color: AppColors.primaryColor,
        child: DrawerBody(user: user, tamwenCubit: tamwenCubit),
      ),
    );
  }
}

class DrawerBody extends StatelessWidget {
  const DrawerBody({
    Key? key,
    required this.user,
    required this.tamwenCubit,
  }) : super(key: key);

  final User? user;
  final TamwenCubit tamwenCubit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: const CustomText(
              text: 'الحساب الخاص بك',
            ),
            accountEmail: CustomText(
              text: user!.email!,
            ),
            decoration: const BoxDecoration(color: AppColors.textColor),
          ),
          CustomListTile(
            icon: Icons.home,
            text: AppStrings.homePage,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          CustomListTile(
            icon: Icons.add_card_sharp,
            text: AppStrings.addNewUser,
            onTap: () {
              customNavPush(const AddNewPeople(), context);
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
              customNavPush(
                  TotalCardsScreen(users: tamwenCubit.users), context);
            },
          ),
          CustomListTile(
              icon: Icons.production_quantity_limits,
              text: AppStrings.products,
              onTap: () {
                customNavPush(
                  ProductsScreen(userModel: tamwenCubit.users),
                  context,
                );
              }),
          CustomListTile(
            icon: Icons.logout_outlined,
            text: AppStrings.signOut,
            onTap: () async {
              var loginCubit = BlocProvider.of<LoginCubit>(context);
              customNavPush(const LoginScreen(), context);
              await loginCubit.signOut();
            },
          ),
        ],
      ),
    );
  }
}

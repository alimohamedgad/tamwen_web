// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamwen_web/Core/App_String/product_string.dart';
import 'package:tamwen_web/Core/Services/global_method.dart';
import 'package:tamwen_web/Featurs/View/Screens/auth/login_screen.dart';

import '../../../Controller/Login_Cubit/login_cubit.dart';
import '../../../Controller/People_Cubit/people_cubit.dart';
import '../../../../Core/AppColors/app_colors.dart';
import '../../../../Core/App_String/app_strings.dart';
import '../../Widgets/Custom_Text/custom_text.dart';
import '../../Widgets/custom_list_tile.dart';
import '../Home/add_client.dart';
import '../Home/card_screen.dart';
import 'FlourScreen/flour_screen.dart';
import 'Product_Screen/products_screen.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({
    Key? key,
    required this.peopleCubit,
  }) : super(key: key);

  final PeopleCubit peopleCubit;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: AppColors.primaryColor4,
        child: DrawerBody(peopleCubit: peopleCubit),
      ),
    );
  }
}

class DrawerBody extends StatelessWidget {
  const DrawerBody({
    Key? key,
    required this.peopleCubit,
  }) : super(key: key);

  final PeopleCubit peopleCubit;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return SingleChildScrollView(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: const CustomText(
              text: 'الحساب الخاص بك',
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
            ),
            accountEmail: CustomText(
              text: user!.email!,
            ),
            decoration: const BoxDecoration(
              color: AppColors.textColor,
            ),
          ),
          CustomListTile(
            icon: Icons.home,
            text: AppStrings.homePage,
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(color: AppColors.white),
          CustomListTile(
            icon: Icons.add_card_sharp,
            text: AppStrings.addNewUser,
            onTap: () {
              GlobalMethods.navTo(const AddClient(), context);
            },
          ),
          CustomListTile(
            icon: Icons.people_alt,
            text: AppStrings.totalPerosns,
            onTap: () {
              GlobalMethods.navTo(
                  TotalCardsScreen(users: peopleCubit.users), context);
            },
          ),
          const Divider(color: AppColors.white),
          CustomListTileImageTrailing(
            image: 'assets/img/flour.png',
            text: ProductString.amountFlour,
            onTap: () {
              GlobalMethods.navTo(const FlourScreen(), context);
            },
          ),
          const Divider(color: AppColors.white),
          CustomListTile(
              icon: Icons.production_quantity_limits,
              text: ProductString.products,
              onTap: () {
                GlobalMethods.navTo(
                  ProductsScreen(userModel: peopleCubit.users[0]),
                  context,
                );
              }),
          const Divider(color: AppColors.white),
          CustomListTile(
            icon: Icons.logout_outlined,
            text: AppStringLogin.signOut,
            onTap: () async {
              var loginCubit = BlocProvider.of<LoginCubit>(context);
              await GlobalMethods.warningDialog(
                context,
                content: 'هل تريد تسجيل الخروج ؟',
                title: '',
                onTap: () async {
                  GlobalMethods.navRemoveUntil(const LoginScreen(), context);
                  await loginCubit.signOut(context);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

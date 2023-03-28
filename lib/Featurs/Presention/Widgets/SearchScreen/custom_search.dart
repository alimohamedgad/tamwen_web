// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:tamwen_web/Featurs/Data/model/user_model.dart';
import 'package:tamwen_web/Featurs/Presention/Widgets/Custom_Text/custom_text.dart';
import '../../../Core/AppColors/app_colors.dart';
import '../../../Core/App_String/app_strings.dart';
import '../../Cubits/People_Cubit/people_cubit.dart';
import '../../Screens/Mobile/Home/body_home.dart';

class CustomSearch extends SearchDelegate {
  final List<UserModel> users;
  final PeopleCubit cubit;
  CustomSearch({
    required this.users,
    required this.cubit,
  });

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      hintColor: AppColors.white,
      scaffoldBackgroundColor: AppColors.primaryColor4,
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
      appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: AppColors.primaryColor4,
          iconTheme: IconThemeData(
            color: AppColors.white,
          )),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: AppColors.white,
        ),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(
            Icons.clear,
            color: AppColors.white,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: AppColors.white,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<UserModel> searchForList = [];

    for (var item in users) {
      if (item.name.toLowerCase().startsWith(item.name.toLowerCase())) {
        searchForList.add(item);
      }
    }

    return ConditionalBuilder(
      condition: searchForList.isNotEmpty,
      fallback: (context) => const Center(
        child: CustomText(
          text: AppStrings.wrongName,
        ),
      ),
      builder: (context) => Scaffold(
        body: BodyHomeScreen(
          users: searchForList,
          peopleCubit: cubit,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<UserModel> searchForList = [];
    for (var item in users) {
      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        searchForList.add(item);
      }
    }
    return ConditionalBuilder(
      condition: searchForList.isNotEmpty,
      fallback: (context) => const Center(
        child: Text(
          AppStrings.wrongName,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: AppColors.white),
        ),
      ),
      builder: (context) {
        return Scaffold(
          body: BodyHomeScreen(
            users: searchForList,
            peopleCubit: cubit,
          ),
        );
      },
    );
  }
}

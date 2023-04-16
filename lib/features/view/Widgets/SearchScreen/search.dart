// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Controller/People_Cubit/client_cubit.dart';
import '../../../../Core/AppColors/app_colors.dart';
import '../../../../Core/App_String/app_strings.dart';
import '../../../Controller/People_Cubit/people_state.dart';
import '../../../Model/user.dart';
import '../Custom_Text/custom_text.dart';
import 'search_widget.dart';

class CustomSearch extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      hintColor: AppColors.white,
      scaffoldBackgroundColor: AppColors.primaryColor4,
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
      appBarTheme: const AppBarTheme(
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

    for (var item in ClientCubit.get(context).users) {
      if (item.name.toLowerCase().startsWith(item.name.toLowerCase())) {
        searchForList.add(item);
      }
    }

    return BlocBuilder<ClientCubit, ClientState>(
      builder: (context, state) {
        final clientCubit = ClientCubit.get(context);

        return ConditionalBuilder(
          condition: searchForList.isNotEmpty,
          fallback: (context) => const Center(
            child: CustomText(
              AppStrings.wrongName,
            ),
          ),
          builder: (context) => Scaffold(
            body: SearchWidget(
              users: searchForList,
              clientCubit: clientCubit,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<UserModel> searchForList = [];
    for (var item in ClientCubit.get(context).users) {
      if (item.name.toLowerCase().contains(query.toLowerCase())) {
        searchForList.add(item);
      }
    }
    return BlocBuilder<ClientCubit, ClientState>(
      builder: (context, state) {
        final clientCubit = ClientCubit.get(context);

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
              body:
                  SearchWidget(users: searchForList, clientCubit: clientCubit),
            );
          },
        );
      },
    );
  }
}

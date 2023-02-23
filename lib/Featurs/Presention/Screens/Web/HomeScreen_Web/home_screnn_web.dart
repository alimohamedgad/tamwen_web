import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamwen_web/Featurs/Core/AppColors/app_colors.dart';
import 'package:tamwen_web/Featurs/Core/Get_it/get_it.dart';
import '../../../Cubits/Tamwen_Cubit/tamwen_cubit.dart';

import '../../Mobile/Widgets/SearchScreen/custom_search.dart';
import 'body_home_web.dart';

class HomePageWeb extends StatelessWidget {
  const HomePageWeb({super.key});
  static String id = 'HomePage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TamwenCubit>()..getAllUsers(),
      child: BlocConsumer<TamwenCubit, TamwenState>(
        listener: (context, state) {},
        builder: (context, state) {
          var tamwenCubit = TamwenCubit.get(context);
          return Scaffold(
            // appBar: appBarHomePage(context, tamwenCubit),
            body: BodyHomeScreenWeb(
                users: tamwenCubit.users, tamwenCubit: tamwenCubit),
          );
        },
      ),
    );
  }
}

AppBar appBarHomePage(BuildContext context, TamwenCubit cubit) {
  return AppBar(
    // title: Text(
    //   "${cubit.getTotalPerson(users, 4)}",
    //   style: TextStyle(),
    // ),
    centerTitle: true,
    elevation: 0.0,
    actions: [
      IconButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: CustomSearch(users: cubit.users, cubit: cubit),
          );
        },
        icon: const Icon(
          Icons.search,
        ),
      ),
    ],
  );
}

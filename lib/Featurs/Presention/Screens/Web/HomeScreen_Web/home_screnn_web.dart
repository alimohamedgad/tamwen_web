import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamwen_web/Featurs/Core/Get_it/get_it.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/People_Cubit/people_state.dart';
import '../../../Cubits/People_Cubit/people_cubit.dart';

import '../../Mobile/Widgets/SearchScreen/custom_search.dart';
import 'body_home_web.dart';

class HomePageWeb extends StatelessWidget {
  const HomePageWeb({super.key});
  static String id = 'HomePage';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PeopleCubit>()..getAllUsers(),
      child: BlocConsumer<PeopleCubit, PeopleState>(
        listener: (context, state) {},
        builder: (context, state) {
          var peopleCubit = PeopleCubit.get(context);
          return Scaffold(
            // appBar: appBarHomePage(context, PeopleCubit),
            body: BodyHomeScreenWeb(
                users: peopleCubit.users, peopleCubit: peopleCubit),
          );
        },
      ),
    );
  }
}

AppBar appBarHomePage(BuildContext context, PeopleCubit cubit) {
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

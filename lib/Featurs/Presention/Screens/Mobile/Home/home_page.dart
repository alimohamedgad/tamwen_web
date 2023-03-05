import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Get_it/get_it.dart';
import '../../../Cubits/People_Cubit/people_state.dart';
import '../Drawer/drawer_screens.dart';
import '../../../Cubits/People_Cubit/people_cubit.dart';
import 'body_home_screen.dart';

import '../Widgets/SearchScreen/custom_search.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
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
            appBar: appBarHomePage(context, peopleCubit),
            drawer: DrawerScreen(peopleCubit: peopleCubit),
            body: BodyHomeScreen(
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
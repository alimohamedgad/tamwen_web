import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Get_it/get_it.dart';
import '../../../Cubits/People_Cubit/people_state.dart';
import '../Drawer/drawer_screens.dart';
import '../../../Cubits/People_Cubit/people_cubit.dart';
import 'body_home.dart';

import '../../../Widgets/SearchScreen/custom_search.dart';

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
          body: BodyHomeScreen(
              users: peopleCubit.users, peopleCubit: peopleCubit),
        );
      },
    );
  }
}

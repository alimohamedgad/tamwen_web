import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Get_it/get_it.dart';
import '../../../Controller/People_Cubit/people_cubit.dart';
import '../../../Controller/People_Cubit/people_state.dart';
import '../Drawer/drawer_screens.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PeopleCubit>()..getUser(),
      child: BlocConsumer<PeopleCubit, PeopleState>(
        listener: (context, state) {},
        builder: (context, state) {
          var peopleCubit = PeopleCubit.get(context);

          return Scaffold(
              // appBar: appBarHomePage(context, peopleCubit),
              appBar: AppBar(),
              drawer: DrawerScreen(peopleCubit: peopleCubit),
              body: Center(child: Text('Admin')));
        },
      ),
    );
  }
}

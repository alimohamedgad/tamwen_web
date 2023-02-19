import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../DrawerScreen/drawer_screens.dart';
import '../../Cubits/Tamwen_Cubit/tamwen_cubit.dart';
import 'body_home_screen.dart';

import '../../Widgets/SearchScreen/custom_search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<TamwenCubit>(context).getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TamwenCubit, TamwenState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = TamwenCubit.get(context);

        return Scaffold(
          appBar: appBarHomePage(context, cubit),
          drawer: DrawerScreen(users: cubit.users),
          body: BodyHomeScreen(users: cubit.users, cubit: cubit),
        );
      },
    );
  }
}

AppBar appBarHomePage(
  BuildContext context,
  TamwenCubit cubit,
) {
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

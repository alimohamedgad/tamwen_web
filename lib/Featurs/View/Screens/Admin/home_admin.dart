import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamwen_web/Featurs/Controller/People_Cubit/client_cubit.dart';

import '../../../../Core/Get_it/get_it.dart';
import '../Drawer/drawer_screens.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    var clientCubit = ClientCubit.get(context);

    return BlocProvider(
      create: (context) => getIt<ClientCubit>()..getUser(),
      child: Scaffold(
        // appBar: appBarHomePage(context, ClientCubit),
        appBar: AppBar(),
        drawer: DrawerScreen(),
        body: Center(
          child: Text('Admin'),
        ),
      ),
    );
  }
}

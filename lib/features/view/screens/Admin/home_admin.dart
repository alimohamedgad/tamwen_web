import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../controller/client_cubit/client_cubit.dart';
import '../Drawer/drawer_screens.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    var clientCubit = ClientCubit.get(context);

    return BlocProvider(
      create: (context) => ClientCubit()..getUser(),
      child: Scaffold(
        // appBar: appBarHomePage(context, ClientCubit),
        appBar: AppBar(),
        drawer: const DrawerScreen(),
        body: const Center(
          child: Text('Admin'),
        ),
      ),
    );
  }
}

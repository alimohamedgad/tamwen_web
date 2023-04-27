// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Controller/Flour_Cubit/flour_cubit.dart';
import 'flour_body.dart';

class FlourScreen extends StatelessWidget {
  const FlourScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FlourCubit()..getFlours(),
      child: Scaffold(
        appBar: AppBar(),
        body: const BodyFlourScreen(),
      ),
    );
  }
}

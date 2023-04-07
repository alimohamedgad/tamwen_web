// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Controller/Flour_Cubit/flour_cubit.dart';
import 'flour_body.dart';

class FlourScreen extends StatefulWidget {
  const FlourScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FlourScreen> createState() => _FlourScreenState();
}

class _FlourScreenState extends State<FlourScreen> {
  @override
  void initState() {
    BlocProvider.of<FlourCubit>(context).getFlours();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var flourCubit = BlocProvider.of<FlourCubit>(context);
    return Scaffold(
      appBar: AppBar(),
      body: BodyFlourScreen(
        flourList: flourCubit.flourList,
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Cubits/Tamwen_Cubit/tamwen_cubit.dart';
import 'body_screen_defrenet_people.dart';

class TotalPeopeEqualOne extends StatelessWidget {
  final Object isEqualTo;

  const TotalPeopeEqualOne({
    Key? key,
    required this.isEqualTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TamwenCubit, TamwenState>(builder: (context, state) {
      var tamwenCubit = TamwenCubit.get(context);
      // stream: UsersDataBase.getAllUsersForDeferentPerson(isEqualTo),
      return Scaffold(
        appBar: AppBar(),
        body: BodyScreenForDeferentPeople(
            tamwenCubit: tamwenCubit, isEqualTo: isEqualTo),
      );
    });
  }
}

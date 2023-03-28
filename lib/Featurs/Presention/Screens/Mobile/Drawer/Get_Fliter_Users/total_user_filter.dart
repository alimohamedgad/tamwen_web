// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/People_Cubit/people_state.dart';

import '../../../../Cubits/People_Cubit/people_cubit.dart';
import 'body_defrenet_people.dart';

class TotalPeopeEqualOne extends StatelessWidget {
  final Object isEqualTo;

  const TotalPeopeEqualOne({
    Key? key,
    required this.isEqualTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeopleCubit, PeopleState>(builder: (context, state) {
      var peopleCubit = PeopleCubit.get(context);
      return Scaffold(
        appBar: AppBar(),
        body: BodyScreenForDeferentPeople(
            peopleCubit: peopleCubit, isEqualTo: isEqualTo),
      );
    });
  }
}

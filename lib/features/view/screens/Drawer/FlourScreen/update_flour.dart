// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamwen_web/features/Controller/Flour_Cubit/flour_cubit.dart';

import '../../../../../Core/dumy_data.dart';
import '../../../../Model/flour.dart';
import '../../../../model/user.dart';
import '../../../Widgets/CustomButton/custom_button.dart';
import '../../../Widgets/CustomDropDown/custom_drop_button.dart';
import '../../../Widgets/custom_text_field.dart';

class UpdateFlour extends StatefulWidget {
  final UserModel? users;
  final FlourModel? flourModel;
  final FlourCubit flourCubit;
  const UpdateFlour({
    Key? key,
    this.users,
    this.flourModel,
    required this.flourCubit,
  }) : super(key: key);

  @override
  State<UpdateFlour> createState() => _UpdateFlourState();
}

class _UpdateFlourState extends State<UpdateFlour> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<FlourCubit>(context).selectedAmountFlour =
        widget.flourModel!.amountFlour.toString();
    BlocProvider.of<FlourCubit>(context).selectRound = widget.flourModel!.round;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = FlourCubit.get(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 100, 5, 0),
          child: Column(
            children: [
              CustomTextfield(
                keyBordTyp: TextInputType.emailAddress,
                hintText: 'ادخل اسم العميل',
                icon: Icons.person,
                initialValue: widget.flourModel?.nameClient,
              ),
              const SizedBox(height: 10),
              CustomDropDownField(
                hint: 'اختر كمية الدقيق',
                selectValue: cubit.selectedAmountFlour.toString(),
                items: amountFlourList
                    .map((e) => DropdownMenuItem(
                          value: "$e",
                          child: Text("$e"),
                        ))
                    .toList(),
                onChange: (newVal) {
                  cubit.selectedAmountFlour = newVal.toString();
                },
              ),
              const SizedBox(height: 10),
              CustomDropDownField(
                hint: 'اختر الدور ',
                selectValue: cubit.selectRound,
                items: roundList
                    .map((e) => DropdownMenuItem(
                          value: e.round,
                          child: Text(e.round),
                        ))
                    .toList(),
                onChange: (newVal) {
                  cubit.selectRound = newVal.toString();
                },
              ),
              const SizedBox(height: 10),
              _buildUpdateFlour(cubit),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpdateFlour(FlourCubit cubit) {
    return BlocBuilder<FlourCubit, FlourState>(
      builder: (context, state) {
        if (state is UpdateFlourLoading) {
          return const CircularProgressIndicator();
        } else {
          return CustomButton(
            onPressed: () {
              cubit.updateFlour(
                FlourModel(
                  id: widget.flourModel?.id,
                  nameClient: widget.flourModel!.nameClient,
                  round: cubit.selectRound.toString(),
                  amountFlour: int.parse(cubit.selectedAmountFlour.toString()),
                ),
              );
              Navigator.pop(context);
            },
            text: 'تحديث  الدقيق',
          );
        }
      },
    );
  }
}

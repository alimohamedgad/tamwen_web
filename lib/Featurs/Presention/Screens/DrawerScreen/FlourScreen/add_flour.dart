// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamwen_web/Featurs/Data/model/user_model.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/Flour_Cubit/flour_cubit.dart';
import 'package:tamwen_web/Featurs/Presention/Widgets/custom_text_field.dart';

import '../../../../Data/Data_Source/FireStore_DataBase/flour_database.dart';
import '../../../../Data/model/flour_model.dart';
import '../../../Cubits/Tamwen_Cubit/tamwen_cubit.dart';
import '../../../Widgets/CustomButton/custom_button.dart';
import '../../../Widgets/CustomDropDown/custom_drop_button.dart';

class AddFlourScreen extends StatelessWidget {
  final UserModel users;
  const AddFlourScreen({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = TamwenCubit.get(context);
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
                initialValue: users.name,
              ),
              const SizedBox(height: 10),
              CustomDropDownField(
                hint: 'اختر كمية الدقيق',
                selectVaule: cubit.selcetedAmountFlour,
                items: cubit.amountFlourList
                    .map((e) => DropdownMenuItem(
                          value: '$e',
                          child: Text("$e"),
                        ))
                    .toList(),
                onChange: (newVal) {
                  cubit.selcetedAmountFlour = newVal.toString();
                },
              ),
              const SizedBox(height: 10),
              CustomDropDownField(
                hint: 'اختر الدور ',
                selectVaule: cubit.selectRound,
                items: cubit.roundList
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
              BlocBuilder<FlourCubit, FlourState>(
                builder: (context, state) {
                  var flourCubit = BlocProvider.of<FlourCubit>(context);
                  return CustomButton(
                    onPressed: () {
                      flourCubit.addFlour(
                        FlourModel(
                          nameClient: users.name,
                          round: cubit.selectRound.toString(),
                          amountFlour:
                              int.parse(cubit.selcetedAmountFlour.toString()),
                        ),
                      );
                    },
                    text: 'اضافة بطاقة دقيق',
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

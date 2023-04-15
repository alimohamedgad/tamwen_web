// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamwen_web/Featurs/Model/user.dart';
import 'package:tamwen_web/Featurs/View/Widgets/custom_text_field.dart';

import '../../../../Controller/Flour_Cubit/flour_cubit.dart';
import '../../../../Model/flour.dart';
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
    final flourCubit = FlourCubit.get(context);
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
                  selectVaule: flourCubit.selcetedAmountFlour,
                  items: flourCubit.amountFlourList
                      .map((e) => DropdownMenuItem(
                            value: '$e',
                            child: Text("$e"),
                          ))
                      .toList(),
                  onChange: (newVal) {
                    flourCubit.selcetedAmountFlour = newVal.toString();
                  },
                ),
                const SizedBox(height: 10),
                CustomDropDownField(
                  hint: 'اختر الدور ',
                  selectVaule: flourCubit.selectRound,
                  items: flourCubit.roundList
                      .map((e) => DropdownMenuItem(
                            value: e.round,
                            child: Text(e.round),
                          ))
                      .toList(),
                  onChange: (newVal) {
                    flourCubit.selectRound = newVal.toString();
                  },
                ),
                const SizedBox(height: 10),
                CustomButton(
                  onPressed: () {
                    flourCubit.addFlour(
                      FlourModel().copyWith(
                        nameClient: users.name,
                        round: flourCubit.selectRound.toString(),
                        amountFlour: int.parse(
                            flourCubit.selcetedAmountFlour.toString()),
                      ),
                    );
                  },
                  text: 'اضافة بطاقة دقيق',
                )
              ],
            ),
          ),
        ));
  }
}

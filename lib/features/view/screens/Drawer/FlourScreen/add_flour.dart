// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tamwen_web/features/view/Widgets/custom_text_field.dart';

import '../../../../../Core/dumy_data.dart';
import '../../../../Controller/Flour_Cubit/flour_cubit.dart';
import '../../../../Model/flour.dart';
import '../../../../model/user.dart';
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
                  selectValue: flourCubit.selectedAmountFlour,
                  items: amountFlourList
                      .map((e) => DropdownMenuItem(
                            value: '$e',
                            child: Text("$e"),
                          ))
                      .toList(),
                  onChange: (newVal) {
                    flourCubit.selectedAmountFlour = newVal.toString();
                  },
                ),
                const SizedBox(height: 10),
                CustomDropDownField(
                  hint: 'اختر الدور ',
                  selectValue: flourCubit.selectRound,
                  items: roundList
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
                            flourCubit.selectedAmountFlour.toString()),
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

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tamwen_web/Featurs/Data/model/flour_model.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/Tamwen_Cubit/tamwen_cubit.dart';

import '../../../../../Data/Data_Source/FireStore_DataBase/flour_database.dart';
import '../../../../../Data/model/user_model.dart';
import '../../../../Widgets/CustomButton/custom_button.dart';
import '../../../../Widgets/CustomDropDown/custom_drop_button.dart';
import '../../../../Widgets/custom_text_field.dart';

class UpdateFlour extends StatefulWidget {
  final UserModel? users;
  final FlourModel? flourModel;
  const UpdateFlour({
    Key? key,
    this.users,
    this.flourModel,
  }) : super(key: key);

  @override
  State<UpdateFlour> createState() => _UpdateFlourState();
}

class _UpdateFlourState extends State<UpdateFlour> {
  @override
  void initState() {
    var cubit = TamwenCubit.get(context);

    cubit.selcetedAmountFlour = widget.flourModel!.amountFlour.toString();
    cubit.selectRound = widget.flourModel!.round;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = TamwenCubit.get(context);
    return BlocBuilder<TamwenCubit, TamwenState>(
      builder: (context, state) {
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
                    selectVaule: cubit.selcetedAmountFlour.toString(),
                    items: cubit.amountFlourList
                        .map((e) => DropdownMenuItem(
                              value: "$e",
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
                  CustomButton(
                    onPressed: () {
                      FlourDataBase.updateFlour(
                        FlourModel(
                          id: widget.flourModel?.id,
                          nameClient: widget.flourModel!.nameClient,
                          round: cubit.selectRound.toString(),
                          amountFlour:
                              int.parse(cubit.selcetedAmountFlour.toString()),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    text: 'اضافة بطاقة دقيق',
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

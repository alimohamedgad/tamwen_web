// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamwen_web/Featurs/Presention/Screens/Mobile/Widgets/Custom_Text/custom_text.dart';

import '../../../../Core/app_strings.dart';
import '../../../../Data/model/user_model.dart';
import '../../../Cubits/Tamwen_Cubit/tamwen_cubit.dart';
import '../Widgets/CustomButton/custom_button.dart';
import '../Widgets/CustomDropDown/custom_drop_button.dart';
import '../Widgets/custom_text_field.dart';

class UpdateUser extends StatefulWidget {
  final UserModel users;
  const UpdateUser({
    Key? key,
    required this.users,
  }) : super(key: key);

  static const String idRouter = 'AddNewPeople';

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  TextEditingController? _nameController;
  TextEditingController? passwordController;

  GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  void initState() {
    var cubit = TamwenCubit.get(context);

    _nameController = TextEditingController(text: widget.users.name);
    passwordController =
        TextEditingController(text: "${widget.users.password}");
    cubit.numMainPeopleSelected = widget.users.numberOfMainPeople.toString();
    cubit.numExtraPeopleSelected = widget.users.numberOfExtraPeople.toString();
    cubit.priceOfExtraPeopleSelected =
        widget.users.priceOfExtraPerople.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TamwenCubit, TamwenState>(
      builder: (context, state) {
        var cubit = TamwenCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            leading: const BackButton(),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Form(
                key: key,
                child: Column(
                  children: [
                    CustomTextfield(
                      controller: _nameController,
                      hintText: AppStrings.nameCard,
                      icon: Icons.person,
                      keyBordTyp: TextInputType.name,
                    ),
                    SizedBox(height: 10.h),
                    CustomTextfield(
                      hintText: AppStrings.password,
                      icon: Icons.lock,
                      controller: passwordController,
                      keyBordTyp: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يرجي ادخال الرقم السرى';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    CustomDropDownField(
                      selectVaule: cubit.numMainPeopleSelected,
                      hint: AppStrings.numberOfMainPeople,
                      items: cubit.numberOfMainPeropleList.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: CustomText(
                            text: "${AppStrings.numberOfMainPeople} "
                                " = $e${AppStrings.onePeople}",
                          ),
                        );
                      }).toList(),
                      onChange: (value) {
                        cubit.numMainPeopleSelected = value.toString();
                      },
                    ),
                    SizedBox(height: 10.h),
                    CustomDropDownField(
                      selectVaule: cubit.numExtraPeopleSelected,
                      hint: AppStrings.numberOfExtraPeople,
                      items: cubit.numberOfMainPeropleList.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: CustomText(
                            text: "${AppStrings.numberOfExtraPeople} "
                                " = $e${AppStrings.onePeople}",
                          ),
                        );
                      }).toList(),
                      onChange: (value) {
                        cubit.numExtraPeopleSelected = value.toString();
                      },
                    ),
                    SizedBox(height: 10.h),
                    CustomDropDownField(
                      selectVaule: cubit.priceOfExtraPeopleSelected,
                      hint: AppStrings.priceOfExtraPeople,
                      items: cubit.priceForPersonList.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: CustomText(
                            text: "${AppStrings.priceOfExtraPeople} "
                                " = $e${AppStrings.pound}",
                          ),
                        );
                      }).toList(),
                      onChange: (value) {
                        cubit.priceOfExtraPeopleSelected = value.toString();
                      },
                    ),
                    SizedBox(height: 10.h),
                    CustomButton(
                        onPressed: () {
                          cubit
                              .updateUser(
                            UserModel(
                              id: widget.users.id,
                              name: _nameController!.text,
                              password: int.parse(passwordController!.text),
                              numberOfMainPeople: int.parse(
                                  cubit.numMainPeopleSelected.toString()),
                              numberOfExtraPeople: int.parse(
                                  cubit.numExtraPeopleSelected.toString()),
                              priceOfExtraPerople: int.parse(
                                  cubit.priceOfExtraPeopleSelected.toString()),
                            ),
                          )
                              .then((value) {
                            Navigator.pop(context);
                          });
                        },
                        text: AppStrings.editUser),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

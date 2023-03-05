// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamwen_web/Featurs/Core/App_String/strings.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/People_Cubit/people_state.dart';
import 'package:tamwen_web/Featurs/Presention/Screens/Mobile/Widgets/Custom_Text/custom_text.dart';
import 'package:tamwen_web/Featurs/Presention/Screens/Mobile/Widgets/custom_text_field.dart';

import '../../../../Core/app_strings.dart';
import '../../../../Data/model/user_model.dart';
import '../../../Cubits/People_Cubit/people_cubit.dart';
import '../../Mobile/Widgets/CustomButton/custom_button.dart';
import '../../Mobile/Widgets/CustomDropDown/custom_drop_button.dart';

class UpdateUserWeb extends StatefulWidget {
  final UserModel users;
  const UpdateUserWeb({
    Key? key,
    required this.users,
  }) : super(key: key);

  static const String idRouter = 'AddNewPeople';

  @override
  State<UpdateUserWeb> createState() => _UpdateUserWebState();
}

class _UpdateUserWebState extends State<UpdateUserWeb> {
  TextEditingController? _nameController;
  TextEditingController? passwordController;

  GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  void initState() {
    var cubit = PeopleCubit.get(context);

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
    return BlocBuilder<PeopleCubit, PeopleState>(
      builder: (context, state) {
        var cubit = PeopleCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            leading: const BackButton(),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: key,
              child: Center(
                child: Container(
                  width: 130.w,
                  margin: const EdgeInsets.only(top: 100),
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
                        items: listFromZeroTo9.map((e) {
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
                        items: listFromZeroTo9.map((e) {
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
                                priceOfExtraPerople: int.parse(cubit
                                    .priceOfExtraPeopleSelected
                                    .toString()),
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
          ),
        );
      },
    );
  }
}

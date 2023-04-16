// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Core/AppColors/app_colors.dart';
import '../../../../Core/dumy_data.dart';
import '../../../../Core/Services/utils.dart';
import '../../../../Core/App_String/app_strings.dart';
import '../../../../Core/App_String/product_string.dart';
import '../../../Controller/People_Cubit/client_cubit.dart';
import '../../../Controller/People_Cubit/people_state.dart';
import '../../../Model/user.dart';
import '../../Widgets/CustomButton/custom_button.dart';
import '../../Widgets/CustomDropDown/custom_drop_button.dart';
import '../../Widgets/Custom_Text/custom_text.dart';
import '../../Widgets/custom_text_field.dart';

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
    final cubit = ClientCubit.get(context);
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
  void dispose() {
    _nameController!.dispose();
    passwordController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = ClientCubit.get(context);
    return BlocListener<ClientCubit, ClientState>(
      listener: (context, state) {
        if (state is UpdateUserLoading) {
          Utils.snackBar('يرجي الانتظار', AppColors.green);
        } else if (state is UpdateUserSuccess) {
          Utils.snackBar('تم تحديث البطاقة بنجاح ', AppColors.green);
        }
      },
      child: Scaffold(
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
                    items: listFromZeroTo9.map((e) {
                      return DropdownMenuItem(
                        value: '$e',
                        child: CustomText(
                          "${AppStrings.numberOfMainPeople} "
                          " = $e${ProductString.onePeople}",
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
                        value: '$e',
                        child: CustomText(
                          "${AppStrings.numberOfExtraPeople} "
                          " = $e${ProductString.onePeople}",
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
                    items: priceForOnePerson.map((e) {
                      return DropdownMenuItem(
                        value: '$e',
                        child: CustomText(
                          "${AppStrings.priceOfExtraPeople} "
                          " = $e${ProductString.pound}",
                        ),
                      );
                    }).toList(),
                    onChange: (value) {
                      cubit.priceOfExtraPeopleSelected = value.toString();
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomButton(
                    onPressed: () async {
                      await cubit
                          .updateUser(
                        UserModel(
                          id: widget.users.id,
                          name: _nameController!.text,
                          password: int.parse(passwordController!.text),
                          numberOfMainPeople:
                              int.parse(cubit.numMainPeopleSelected.toString()),
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
                    text: AppStrings.editUser,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

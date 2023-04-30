// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamwen_web/Core/Services/global_method.dart';
import 'package:tamwen_web/features/controller/client_cubit/client_cubit.dart';
import 'package:tamwen_web/features/controller/client_cubit/client_state.dart';
import 'package:tamwen_web/features/view/screens/Home/home_page.dart';

import '../../../../Core/AppColors/app_colors.dart';
import '../../../../Core/dumy_data.dart';
import '../../../../Core/Services/utils.dart';
import '../../../../Core/App_String/app_strings.dart';
import '../../../../Core/App_String/product_string.dart';
import '../../../model/user.dart';
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

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    final cubit = ClientCubit.get(context);
    _nameController = TextEditingController(text: widget.users.name);
    passwordController =
        TextEditingController(text: "${widget.users.password}");
    cubit.numMainPeopleSelected = widget.users.numberOfMainPeople.toString();
    cubit.numExtraPeopleSelected = widget.users.numberOfExtraPeople.toString();
    cubit.priceOfExtraPeopleSelected = widget.users.price.toString();
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
          GlobalMethods.showProgressIndicator(context);
        } else if (state is UpdateUserSuccess) {
          Navigator.pop(context);
          GlobalMethods.navTo(const HomePage(), context);
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
              key: formKey,
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
                    selectValue: cubit.numMainPeopleSelected,
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
                    selectValue: cubit.numExtraPeopleSelected,
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
                    selectValue: cubit.priceOfExtraPeopleSelected,
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
                      GlobalMethods.showProgressIndicator(context);
                      updateClient(cubit);
                      Navigator.pop(context);
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

  Future<void> updateClient(ClientCubit cubit) async {
    await cubit.updateUser(
      UserModel(
        id: widget.users.id,
        name: _nameController!.text,
        password: int.parse(passwordController!.text),
        numberOfMainPeople: int.parse(cubit.numMainPeopleSelected.toString()),
        numberOfExtraPeople: int.parse(cubit.numExtraPeopleSelected.toString()),
        price: int.parse(cubit.priceOfExtraPeopleSelected.toString()),
      ),
    );
  }
}

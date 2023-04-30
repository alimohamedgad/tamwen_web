// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Core/dumy_data.dart';
import '../../../../Core/Services/utils.dart';
import '../../../../Core/AppColors/app_colors.dart';
import '../../../../Core/App_String/product_string.dart';
import '../../../../Core/App_String/app_strings.dart';
import '../../../../Core/Services/global_method.dart';
import '../../../controller/client_cubit/client_cubit.dart';
import '../../../controller/client_cubit/client_state.dart';
import '../../../model/user.dart';
import '../../Widgets/CustomButton/custom_button.dart';
import '../../Widgets/CustomDropDown/custom_drop_button.dart';
import '../../Widgets/Custom_Text/custom_text.dart';
import '../../Widgets/custom_text_field.dart';
import 'home_page.dart';

class AddClient extends StatefulWidget {
  const AddClient({
    Key? key,
  }) : super(key: key);

  static const String idRouter = 'AddNewPeople';

  @override
  State<AddClient> createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = ClientCubit.get(context);

    return BlocListener<ClientCubit, ClientState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is AddUserLoading) {
          GlobalMethods.showProgressIndicator(context);
        }
        if (state is AddUserSuccess) {
          Navigator.pop(context);
          GlobalMethods.navTo(const HomePage(), context);
          Utils.snackBar(' تمت اضافة بطاقة جديدة بنجاح ', AppColors.black);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColors.primaryColor,
          leading: const BackButton(color: AppColors.white),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 100, left: 5, right: 5),
              child: Column(
                children: [
                  CustomTextfield(
                    hintText: AppStrings.nameCard,
                    icon: Icons.person,
                    controller: nameController,
                    keyBordTyp: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'يرجي ادخال الاسم';
                      }
                      return null;
                    },
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
                    items: mainPeopleList.map((e) {
                      return DropdownMenuItem(
                        value: "$e",
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
                        value: "$e",
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
                    onPressed: () {
                      GlobalMethods.showProgressIndicator(context);
                      _addClient(cubit);
                      Navigator.pop(context);
                    },
                    text: AppStrings.addNewUser,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addClient(ClientCubit cubit) async {
    if (!formKey.currentState!.validate()) {
      Navigator.pop(context);
      return;
    } else {
      formKey.currentState!.save();
      ClientCubit.get(context).addUsers(
        UserModel(
          name: nameController.text,
          password: int.parse(passwordController.text),
          numberOfMainPeople: int.parse(cubit.numMainPeopleSelected.toString()),
          numberOfExtraPeople:
              int.parse(cubit.numExtraPeopleSelected.toString()),
          price: int.parse(cubit.priceOfExtraPeopleSelected.toString()),
        ),
      );
    }
  }
}

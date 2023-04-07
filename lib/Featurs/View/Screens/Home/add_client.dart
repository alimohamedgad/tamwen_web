// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamwen_web/Featurs/Controller/People_Cubit/people_state.dart';
import 'package:tamwen_web/Featurs/View/Widgets/Custom_Text/custom_text.dart';

import '../../../Controller/People_Cubit/people_cubit.dart';
import '../../../../Core/AppColors/app_colors.dart';
import '../../../../Core/App_String/product_string.dart';
import '../../../../Core/App_String/strings.dart';
import '../../../../Core/App_String/app_strings.dart';
import '../../../../Core/Services/global_method.dart';
import '../../../Model/user.dart';
import '../../Widgets/CustomButton/custom_button.dart';
import '../../Widgets/CustomDropDown/custom_drop_button.dart';
import '../../Widgets/custom_text_field.dart';
import 'home_page.dart';

class AddClient extends StatelessWidget {
  const AddClient({
    Key? key,
  }) : super(key: key);

  static const String idRouter = 'AddNewPeople';

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    var cubit = PeopleCubit.get(context);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.primaryColor,
        leading: const BackButton(color: AppColors.white),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
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
                  selectVaule: cubit.numMainPeopleSelected,
                  hint: AppStrings.numberOfMainPeople,
                  items: mainPeopleList.map((e) {
                    return DropdownMenuItem(
                      value: "$e",
                      child: CustomText(
                        text: "${AppStrings.numberOfMainPeople} "
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
                      value: "$e",
                      child: CustomText(
                        text: "${AppStrings.numberOfExtraPeople} "
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
                        text: "${AppStrings.priceOfExtraPeople} "
                            " = $e${ProductString.pound}",
                      ),
                    );
                  }).toList(),
                  onChange: (value) {
                    cubit.priceOfExtraPeopleSelected = value.toString();
                  },
                ),
                SizedBox(height: 10.h),
                BlocBuilder<PeopleCubit, PeopleState>(
                  builder: (context, state) {
                    return CustomButton(
                      onPressed: () {
                        _addClient(formKey, cubit, nameController,
                            passwordController, context);
                      },
                      text: AppStrings.addNewUser,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _addClient(
    GlobalKey<FormState> formKey,
    PeopleCubit cubit,
    TextEditingController nameController,
    TextEditingController passwordController,
    BuildContext context) {
  if (formKey.currentState!.validate()) {
    formKey.currentState!.save();

    cubit.addUsers(
      UserModel(
        name: nameController.text,
        password: int.parse(passwordController.text),
        numberOfMainPeople: int.parse(cubit.numMainPeopleSelected.toString()),
        numberOfExtraPeople: int.parse(cubit.numExtraPeopleSelected.toString()),
        priceOfExtraPerople:
            int.parse(cubit.priceOfExtraPeopleSelected.toString()),
      ),
    );
    GlobalMethods.navTo(const HomePage(), context);
  }
}



//  Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           AppStrings.priceOfExtraPeople,
//                           style: TextStyle(fontSize: 25),
//                         ),
//                         Container(
//                           width: 200,
//                           height: 60,
//                           child: DropdownButtonFormField2(
//                             key: _formKey,
//                             decoration: InputDecoration(
//                               isDense: true,
//                               contentPadding: const EdgeInsets.all(10),
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                             ),
//                             hint: const Text('سعر الفرد فى السلع'),
//                             items: cubit.priceForPersonList.map((e) {
//                               return DropdownMenuItem(
//                                 value: e,
//                                 child: Text(e),
//                               );
//                             }).toList(),
//                             value: cubit.selectedAmount,
//                             onChanged: (value) {
//                               cubit.onChangeCustom(value!);
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
                   
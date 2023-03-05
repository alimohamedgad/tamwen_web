// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamwen_web/Featurs/Core/App_String/strings.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/People_Cubit/people_cubit.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/People_Cubit/people_state.dart';
import 'package:tamwen_web/Featurs/Presention/Screens/Web/HomeScreen_Web/home_screnn_web.dart';
import 'package:tamwen_web/Featurs/Presention/Screens/Mobile/Widgets/CustomDropDown/custom_drop_button.dart';
import 'package:tamwen_web/Featurs/Presention/Screens/Mobile/Widgets/Custom_Text/custom_text.dart';

import '../../../../Core/AppColors/app_colors.dart';
import '../../../../Core/app_strings.dart';
import '../../../../Data/model/user_model.dart';
import '../../Mobile/Widgets/CustomButton/custom_button.dart';
import '../../Mobile/Widgets/custom_text_field.dart';
import '../../Mobile/Widgets/navigator.dart';

class AddUserWeb extends StatelessWidget {
  const AddUserWeb({super.key});

  static const String idRouter = 'AddNewPeople';

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return BlocBuilder<PeopleCubit, PeopleState>(
      builder: (context, state) {
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
              child: Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 100),
                  width: 140.w,
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
                        items: listFromZeroTo9.map((e) {
                          return DropdownMenuItem(
                            value: '$e',
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
                            value: '$e',
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
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();

                            cubit
                                .addUsers(
                              UserModel(
                                name: nameController.text,
                                password: int.parse(passwordController.text),
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
                              customNavPush(
                                const HomePageWeb(),
                                context,
                              );
                            });
                          }
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
      },
    );
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
                   
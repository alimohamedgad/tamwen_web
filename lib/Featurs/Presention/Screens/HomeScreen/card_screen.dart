// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tamwen_web/Featurs/Data/model/user_model.dart';
import 'package:tamwen_web/Featurs/Presention/Widgets/Custom_Text/custom_text.dart';

import '../../../Core/app_colors.dart';
import '../../../Core/app_strings.dart';
import '../../Widgets/navigator.dart';
import '../DrawerScreen/Get_Fliter_Users/total_user_filter.dart';

class TotalCardsScreen extends StatelessWidget {
  final List<UserModel> users;
  const TotalCardsScreen({
    Key? key,
    required this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          customListTileCard(
            1,
            1,
            () {
              customNavPush(const TotalPeopeEqualOne(isEqualTo: 1), context);
            },
          ),
          customListTileCard(
            2,
            2,
            () {
              customNavPush(const TotalPeopeEqualOne(isEqualTo: 2), context);
            },
          ),
          customListTileCard(3, 3, () {
            customNavPush(const TotalPeopeEqualOne(isEqualTo: 3), context);
          }),
          customListTileCard(4, 4, () {
            customNavPush(const TotalPeopeEqualOne(isEqualTo: 4), context);
          }),
          customListTileCard(5, 5, () {
            customNavPush(const TotalPeopeEqualOne(isEqualTo: 5), context);
          }),
          customListTileCard(6, 6, () {
            customNavPush(const TotalPeopeEqualOne(isEqualTo: 6), context);
          }),
          customListTileCard(7, 7, () {
            customNavPush(const TotalPeopeEqualOne(isEqualTo: 7), context);
          }),
          customListTileCard(8, 8, () {
            customNavPush(const TotalPeopeEqualOne(isEqualTo: 8), context);
          }),
        ],
      ),
    );
  }

  InkWell customListTileCard(
      int numberPerson, int numberPersonInList, Function()? onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: AppColors.textColor,
        child: ListTile(
          title: CustomText(
            text: AppStrings.totlePeople(numberPerson),
          ),
          trailing: CustomText(
            text: "${getTotalPerson(users, numberPersonInList)}",
          ),
        ),
      ),
    );
  }

  getTotalPerson(List<UserModel> detailsList, int number) {
    double totalPerson = 0;

    for (var element in detailsList
        .where((element) => element.numberOfMainPeople == number)) {
      if (element.numberOfMainPeople == 1) {
        totalPerson += element.numberOfMainPeople / 1;
      } else if (element.numberOfMainPeople == 2) {
        totalPerson += element.numberOfMainPeople / 2;
      } else if (element.numberOfMainPeople == 3) {
        totalPerson += element.numberOfMainPeople / 3;
      } else if (element.numberOfMainPeople == 4) {
        totalPerson += element.numberOfMainPeople / 4;
      } else if (element.numberOfMainPeople == 5) {
        totalPerson += element.numberOfMainPeople / 5;
      } else if (element.numberOfMainPeople == 6) {
        totalPerson += element.numberOfMainPeople / 6;
      } else if (element.numberOfMainPeople == 7) {
        totalPerson += element.numberOfMainPeople / 7;
      } else if (element.numberOfMainPeople == 8) {
        totalPerson += element.numberOfMainPeople / 8;
      } else {
        totalPerson = 0;
      }
    }
    return totalPerson.toInt();
  }
}

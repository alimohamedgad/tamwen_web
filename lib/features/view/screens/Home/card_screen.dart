// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../Core/AppColors/app_colors.dart';
import '../../../../Core/App_String/app_strings.dart';
import '../../../../Core/Services/global_method.dart';
import '../../../model/card.dart';
import '../../../model/user.dart';
import '../../Widgets/Custom_Text/custom_text.dart';
import '../Drawer/Filter_user/total_user_filter.dart';

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
      body: ListView.builder(
        itemCount: cardModel.length,
        itemBuilder: (context, index) {
          var cardItem = cardModel[index];
          return InkWell(
            onTap: () {
              GlobalMethods.navTo(
                  TotalPeopleEqualOne(isEqualTo: cardItem.isEqualTo), context);
            },
            child: Card(
              color: AppColors.textColor,
              child: ListTile(
                title: CustomText(
                  AppStrings.totlePeople(cardItem.numberPerson),
                ),
                trailing: CustomText(
                  "${getTotalPerson(users, cardItem.numberPersonInList)}",
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

getTotalPerson(List<UserModel> detailsList, int number) {
  double totalPerson = 0;
  for (var element
      in detailsList.where((element) => element.numberOfMainPeople == number)) {
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

List<CardModel> cardModel = [
  const CardModel()
      .copyWith(numberPerson: 1, numberPersonInList: 1, isEqualTo: 1),
  const CardModel()
      .copyWith(numberPerson: 2, numberPersonInList: 2, isEqualTo: 2),
  const CardModel()
      .copyWith(numberPerson: 3, numberPersonInList: 3, isEqualTo: 3),
  const CardModel()
      .copyWith(numberPerson: 4, numberPersonInList: 4, isEqualTo: 4),
  const CardModel()
      .copyWith(numberPerson: 5, numberPersonInList: 5, isEqualTo: 5),
  const CardModel()
      .copyWith(numberPerson: 6, numberPersonInList: 6, isEqualTo: 6),
  const CardModel()
      .copyWith(numberPerson: 7, numberPersonInList: 7, isEqualTo: 7),
  const CardModel()
      .copyWith(numberPerson: 8, numberPersonInList: 8, isEqualTo: 8),
];

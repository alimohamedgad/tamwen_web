import 'package:flutter/material.dart';

const String columnNames = 'names';
const String columnId = 'id';
const String columnName = 'title';
const String columnNumberOfMainPeople = 'numberOfMainPeople';
const String columnNumberOfAdditionalPeople = 'numberOfAdditionalPeople';

const String columnPriceOfExtraPeople = 'priceOfExtraPeople';

const String detailsColumn = 'details';
const String detailsId = 'detailsId';
const String nameProductColumn = 'nameProduct';
const String priceForOneProductColumn = 'price';
const String imageProduct = 'imageProduct';
const String counterColumn = 'counter';

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [home, share, settings];
  static const List<MenuItem> secondItems = [logout];

  static const home = MenuItem(text: 'Home', icon: Icons.home);
  static const share = MenuItem(text: 'Share', icon: Icons.share);
  static const settings = MenuItem(text: 'Settings', icon: Icons.settings);
  static const logout = MenuItem(text: 'Log Out', icon: Icons.logout);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.home:
        //Do something
        break;
      case MenuItems.settings:
        //Do something
        break;
      case MenuItems.share:
        //Do something
        break;
      case MenuItems.logout:
        //Do something
        break;
    }
  }
}

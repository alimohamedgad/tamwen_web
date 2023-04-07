// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Utils {
  BuildContext context;
  Utils(
    this.context,
  );

  Size get screenSize => MediaQuery.of(context).size;

  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static snackBar(String? text, Color color) {
    if (text == null) return;
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: color,
      margin: const EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
    );
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}

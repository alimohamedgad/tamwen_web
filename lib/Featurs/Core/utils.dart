import 'package:flutter/material.dart';

class Utils {
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

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void customNavReplace(Widget newRoute, context) {
  Navigator.pushAndRemoveUntil(
    context,
    PageTransition(
      child: newRoute,
      type: PageTransitionType.fade,
      duration: const Duration(milliseconds: 600),
      reverseDuration: const Duration(milliseconds: 600),
    ),
    (route) => false,
  );
}

void customNavPush(Widget newRoute, context) {
  Navigator.push(
      context,
      PageTransition(
        child: newRoute,
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 600),
        reverseDuration: const Duration(milliseconds: 600),
      ));
}

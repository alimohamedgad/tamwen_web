// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class IncreamentOrDecremant extends StatelessWidget {
  const IncreamentOrDecremant({
    Key? key,
    required this.ontap,
    required this.icon,
    required this.color,
  }) : super(key: key);

  final Function()? ontap;
  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                )
              ]),
          child: Icon(
            icon,
            color: Colors.black,
          )),
    );
  }
}

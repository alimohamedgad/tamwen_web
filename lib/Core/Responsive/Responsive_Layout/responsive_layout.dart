// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileWidget;
  final Widget? webWidget;
  final Widget? tabletWidget;
  const ResponsiveLayout({
    Key? key,
    required this.mobileWidget,
    this.webWidget,
    this.tabletWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth >= 950) {
          return webWidget ?? mobileWidget;
        } else if (constraints.maxWidth >= 600) {
          return tabletWidget ?? mobileWidget;
        } else {
          return mobileWidget;
        }
      },
    );
  }
}

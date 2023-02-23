import 'package:flutter/material.dart';
import 'package:tamwen_web/Featurs/Core/AppColors/app_colors.dart';

ThemeData themeDataLight() {
  return ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColors.primaryColor4,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor4,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(),
  );
}

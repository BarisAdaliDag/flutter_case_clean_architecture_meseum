import 'package:flutter/material.dart';
import 'package:metropolitan_museum/app/common/constants/app_colors.dart';

final class AppThemeData {
  static final ThemeData themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.ghostWhite,
    bottomNavigationBarTheme: _bottomNavigationBarTheme,
    appBarTheme: _appBarTheme,
  );

  static const BottomNavigationBarThemeData _bottomNavigationBarTheme = BottomNavigationBarThemeData(
    backgroundColor: AppColors.ghostWhite,
    elevation: 0,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppColors.redValencia,
    unselectedItemColor: AppColors.greyNickel,
    unselectedLabelStyle: TextStyle(
      color: AppColors.ghostWhite,
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
    selectedLabelStyle: TextStyle(
      color: AppColors.ghostWhite,
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
  );

  static const AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: AppColors.ghostWhite,
    centerTitle: true,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    ),
    scrolledUnderElevation: 0,
  );
}

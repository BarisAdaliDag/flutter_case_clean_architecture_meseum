import 'package:flutter/material.dart';
import 'package:metropolitan_museum/app/common/constants/app_colors.dart';
import 'package:metropolitan_museum/app/common/constants/text_style_helper.dart';

final class AppThemeData {
  static final ThemeData lightThemeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.redValencia,
      brightness: Brightness.light,
      surface: AppColors.whiteGost,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.whiteGost,
    bottomNavigationBarTheme: _bottomNavigationBarTheme,
    appBarTheme: _appBarTheme,
    textTheme: _textTheme,
  );

  static final ThemeData darkThemeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.redValencia,
      brightness: Brightness.dark,
      surface: AppColors.black,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.black,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.black,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.redValencia,
      unselectedItemColor: AppColors.greyNickel,
      unselectedLabelStyle: TextStyle(
        color: AppColors.whiteGost,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      selectedLabelStyle: TextStyle(
        color: AppColors.whiteGost,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.black,
      centerTitle: true,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.whiteGost,
      ),
      scrolledUnderElevation: 0,
    ),
    textTheme: _textTheme,
  );

  static const BottomNavigationBarThemeData _bottomNavigationBarTheme = BottomNavigationBarThemeData(
    backgroundColor: AppColors.whiteGost,
    elevation: 0,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppColors.redValencia,
    unselectedItemColor: AppColors.greyNickel,
    unselectedLabelStyle: TextStyle(
      color: AppColors.whiteGost,
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
    selectedLabelStyle: TextStyle(
      color: AppColors.whiteGost,
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
  );

  static const AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: AppColors.whiteGost,
    centerTitle: true,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppColors.black,
    ),
    scrolledUnderElevation: 0,
  );

  static final TextTheme _textTheme = TextTheme(
    displayLarge: TxStyleHelper.heading1,
    displayMedium: TxStyleHelper.heading2,
    displaySmall: TxStyleHelper.heading3,
    headlineMedium: TxStyleHelper.headline,
    bodyMedium: TxStyleHelper.body,
    bodyLarge: TxStyleHelper.bodyBold,
    titleMedium: TxStyleHelper.subheading,
    titleLarge: TxStyleHelper.subheadingBold,
    labelSmall: TxStyleHelper.caption,
    labelMedium: TxStyleHelper.captionBold,
  );
}

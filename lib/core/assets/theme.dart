import 'package:employees/core/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: CustomColors.color6,
  primaryColor: CustomColors.color1,
  colorScheme: const ColorScheme.light(
    primary: CustomColors.color1,
  ),
  listTileTheme: const ListTileThemeData(
    visualDensity: VisualDensity(
      horizontal: 0,
      vertical: -2,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: CustomColors.color3,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        CustomColors.color1,
      ),
      textStyle: MaterialStateProperty.all(
        CustomTypography.buttonLabel,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: CustomTypography.textFieldHint,
    contentPadding: EdgeInsets.symmetric(
      vertical: 5.h,
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: CustomColors.color10,
      ),
    ),
    activeIndicatorBorder: const BorderSide(
      color: CustomColors.color10,
    ),
    focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
      color: CustomColors.color10,
    )),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.zero),
      borderSide: BorderSide(
        color: CustomColors.color10,
      ),
    ),
  ),
);

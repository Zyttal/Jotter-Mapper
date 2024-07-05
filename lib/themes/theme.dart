import 'package:flutter/material.dart';
import 'package:jotter_mapper/themes/custom_color_palette.dart';
import 'package:jotter_mapper/themes/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData appTheme = ThemeData(
    textTheme: AppTextTheme.textTheme,
    primaryColor: ColorPalette.primary100,
    primaryColorDark: ColorPalette.dark100,
    scaffoldBackgroundColor: ColorPalette.dark100,
    appBarTheme: const AppBarTheme(backgroundColor: ColorPalette.dark100),
    inputDecorationTheme: InputDecorationTheme(
        focusColor: ColorPalette.primary100,
        prefixIconColor: ColorPalette.dark400,
        fillColor: ColorPalette.dark300),
    brightness: Brightness.dark,
  );
}

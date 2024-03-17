import 'package:flutter/material.dart';

enum ColorOption { red, yellow, blue, green, purple }

Color getPrimaryColor(ColorOption colorOption, ThemeMode themeMode) {
  switch (colorOption) {
    case ColorOption.red:
      return themeMode == ThemeMode.dark ? Colors.redAccent : Colors.red;
    case ColorOption.yellow:
      return themeMode == ThemeMode.dark ? Colors.yellowAccent : Colors.yellow;
    case ColorOption.blue:
      return themeMode == ThemeMode.dark ? Colors.blueAccent : Colors.blue;
    case ColorOption.green:
      return themeMode == ThemeMode.dark ? Colors.greenAccent : Colors.green;
    case ColorOption.purple:
      return themeMode == ThemeMode.dark ? Colors.purpleAccent : Colors.purple;
  }
}

// Light Theme
Color? appBarBackgroundColorLight = Colors.grey[350];
const Color appBarIconColorLight = Colors.black;
const Color appBarTextColorLight = Colors.black;
Color? bottomNavBarBackgroundColorLight = Colors.grey[350];
const Color elevatedButtonForegroundColorLight = Colors.black;
const Color floatingActionButtonForegroundColorLight = Colors.black;
const Color checkboxCheckColorLight = Colors.white;
Color? secondaryColorLight = Colors.grey[100];
Color? tertiaryColorLight = Colors.grey[300];
const Color switchColorLight = Colors.grey;

// Dark Theme
const Color bottomNavBarBackgroundColorDark = Color(0xFF141414);
const Color elevatedButtonForegroundColorDark = Colors.black;
const Color floatingActionButtonForegroundColorDark = Colors.black;
const Color checkboxCheckColorDark = Colors.white;
Color? secondaryColorDark = Colors.grey[800];
Color? tertiaryColorDark = Colors.grey[600];
const Color switchColorDark = Colors.grey;

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

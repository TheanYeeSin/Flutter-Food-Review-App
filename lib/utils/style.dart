import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:foodreviewapp/utils/color.dart";

ThemeData lightTheme(BuildContext context) {
  final colorMode = context.watch<ThemeManager>().colorMode;
  final themeMode = context.watch<ThemeManager>().themeMode;
  final mainColor = getPrimaryColor(colorMode, themeMode);

  return ThemeData(
    useMaterial3: false,
    primaryColor: mainColor,
    brightness: Brightness.light,
    fontFamily: GoogleFonts.poppins().fontFamily,
    appBarTheme: AppBarTheme(
      backgroundColor: appBarBackgroundColorLight,
      elevation: 2,
      iconTheme: const IconThemeData(color: appBarIconColorLight),
      titleTextStyle: const TextStyle(
        color: appBarTextColorLight,
        fontSize: 22,
        fontFamily: String.fromEnvironment('poppins'),
      ),
      actionsIconTheme: const IconThemeData(color: appBarIconColorLight),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: bottomNavBarBackgroundColorLight,
      elevation: 2,
      selectedItemColor: mainColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(mainColor),
        foregroundColor: MaterialStateProperty.all<Color>(
          elevatedButtonForegroundColorLight,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: mainColor,
      foregroundColor: floatingActionButtonForegroundColorLight,
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor:
          MaterialStateColor.resolveWith((states) => checkboxCheckColorLight),
      fillColor: MaterialStateColor.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return mainColor; // Fill color when checked
          }
          return Colors.transparent;
        },
      ),
    ),
    colorScheme: const ColorScheme.light().copyWith(
      secondary: secondaryColorLight,
      tertiary: tertiaryColorLight,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(mainColor),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusColor: mainColor,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: mainColor),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return mainColor; // Color when the switch is in the "on" state
          }
          return switchColorLight; // Color when the switch is in the "off" state
        },
      ),
      trackColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return mainColor.withOpacity(
              0.5,
            ); // Track color when the switch is in the "on" state
          }
          return switchColorLight.withOpacity(
            0.5,
          ); // Track color when the switch is in the "off" state
        },
      ),
    ),
  );
}

ThemeData darkTheme(BuildContext context) {
  final colorMode = context.watch<ThemeManager>().colorMode;
  final themeMode = context.watch<ThemeManager>().themeMode;
  final mainColor = getPrimaryColor(colorMode, themeMode);
  return ThemeData(
    useMaterial3: false,
    primaryColor: mainColor,
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.poppins().fontFamily,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: bottomNavBarBackgroundColorDark,
      elevation: 2,
      selectedItemColor: mainColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(mainColor),
        foregroundColor:
            MaterialStateProperty.all<Color>(elevatedButtonForegroundColorDark),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: mainColor,
      foregroundColor: floatingActionButtonForegroundColorDark,
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor:
          MaterialStateColor.resolveWith((states) => checkboxCheckColorDark),
      fillColor: MaterialStateColor.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return mainColor; // Fill color when checked
          }
          return Colors.transparent;
        },
      ),
    ),
    colorScheme: const ColorScheme.dark().copyWith(
      secondary: Colors.grey[800],
      tertiary: Colors.grey[600],
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(mainColor),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return mainColor; // Color when the switch is in the "on" state
          }
          return switchColorDark; // Color when the switch is in the "off" state
        },
      ),
      trackColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return mainColor.withOpacity(
              0.5,
            ); // Track color when the switch is in the "on" state
          }
          return switchColorDark.withOpacity(
            0.5,
          ); // Track color when the switch is in the "off" state
        },
      ),
    ),
  );
}

class ThemeManager extends ChangeNotifier {
  static ThemeMode _themeMode = ThemeMode.light;
  static ColorOption _colorMode = ColorOption.blue;

  ThemeMode get themeMode => _themeMode;
  ColorOption get colorMode => _colorMode;

  ThemeManager() {
    _loadSavedThemeMode();
    _loadSavedColorMode();
  }

  Future<void> _loadSavedThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ThemeMode savedThemeMode =
        ThemeMode.values[prefs.getInt('themeMode') ?? ThemeMode.system.index];
    _themeMode = savedThemeMode;
    notifyListeners();
  }

  toggleTheme(ThemeMode themeMode) async {
    _themeMode = themeMode;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', themeMode.index);
  }

  Future<void> _loadSavedColorMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ColorOption savedColorMode =
        ColorOption.values[prefs.getInt('colorMode') ?? ColorOption.blue.index];
    _colorMode = savedColorMode;
    notifyListeners();
  }

  toggleColor(ColorOption colorMode) async {
    _colorMode = colorMode;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('colorMode', colorMode.index);
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
    brightness: Brightness.light,
    fontFamily: GoogleFonts.poppins().fontFamily,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[350],
      elevation: 2,
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontFamily: String.fromEnvironment('poppins')),
      actionsIconTheme: const IconThemeData(color: Colors.black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.blue, foregroundColor: Colors.black),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateColor.resolveWith((states) => Colors.white),
      fillColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.blue; // Fill color when checked
        }
        return Colors.transparent;
      }),
    ),
    colorScheme: const ColorScheme.light().copyWith(
      secondary: Colors.grey[100],
      tertiary: Colors.grey[300],
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.blue; // Color when the switch is in the "on" state
          }
          return Colors.grey; // Color when the switch is in the "off" state
        },
      ),
      trackColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.blue.withOpacity(
                0.5); // Track color when the switch is in the "on" state
          }
          return Colors.grey.withOpacity(
              0.5); // Track color when the switch is in the "off" state
        },
      ),
    ));

ThemeData darkTheme = ThemeData(
    primaryColor: Colors.lightBlue,
    brightness: Brightness.dark,
    fontFamily: GoogleFonts.poppins().fontFamily,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.lightBlue, foregroundColor: Colors.black),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateColor.resolveWith((states) => Colors.white),
      fillColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.lightBlue; // Fill color when checked
        }
        return Colors.transparent;
      }),
    ),
    colorScheme: const ColorScheme.dark().copyWith(
      secondary: Colors.grey[800],
      tertiary: Colors.grey[600],
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.lightBlue),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors
                .lightBlue; // Color when the switch is in the "on" state
          }
          return Colors.grey; // Color when the switch is in the "off" state
        },
      ),
      trackColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.lightBlue.withOpacity(
                0.5); // Track color when the switch is in the "on" state
          }
          return Colors.grey.withOpacity(
              0.5); // Track color when the switch is in the "off" state
        },
      ),
    ));

class ThemeManager extends ChangeNotifier {
  static ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  ThemeManager() {
    _loadSavedThemeMode();
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
}

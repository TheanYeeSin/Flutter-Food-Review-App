import 'package:flutter/material.dart';
import 'package:foodreviewapp/utils/color.dart';
import 'package:foodreviewapp/utils/style.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppearanceSettingScreen extends StatefulWidget {
  const AppearanceSettingScreen({super.key});

  @override
  State<AppearanceSettingScreen> createState() =>
      _AppearanceSettingScreenState();
}

class _AppearanceSettingScreenState extends State<AppearanceSettingScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeMode selectedThemeMode = context.watch<ThemeManager>().themeMode;
    ColorOption selectedColorMode = context.watch<ThemeManager>().colorMode;
    void updateTheme(ThemeMode? themeMode) {
      if (themeMode != null) {
        selectedThemeMode = themeMode;
        context
            .read<ThemeManager>()
            .toggleTheme(themeMode); // Update the theme using the provider
      }
    }

    void updateColor(ColorOption? colorMode) {
      if (colorMode != null) {
        selectedColorMode = colorMode;
        context
            .read<ThemeManager>()
            .toggleColor(colorMode); // Update the color using the provider
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appearanceSettingTitle),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.brush_outlined),
            title: Text(AppLocalizations.of(context)!.themeSetting),
            trailing: DropdownButton(
              value: selectedThemeMode,
              onChanged: updateTheme,
              items: [
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(AppLocalizations.of(context)!.lightTheme),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(AppLocalizations.of(context)!.darkTheme),
                ),
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text(AppLocalizations.of(context)!.systemDefault),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: Text(AppLocalizations.of(context)!.colorThemeSetting),
            trailing: DropdownButton(
              value: selectedColorMode,
              onChanged: updateColor,
              items: [
                DropdownMenuItem(
                  value: ColorOption.red,
                  child: Text(AppLocalizations.of(context)!.redSetting),
                ),
                DropdownMenuItem(
                  value: ColorOption.yellow,
                  child: Text(AppLocalizations.of(context)!.yellowSetting),
                ),
                DropdownMenuItem(
                  value: ColorOption.blue,
                  child: Text(AppLocalizations.of(context)!.blueSetting),
                ),
                DropdownMenuItem(
                  value: ColorOption.green,
                  child: Text(AppLocalizations.of(context)!.greenSetting),
                ),
                DropdownMenuItem(
                  value: ColorOption.purple,
                  child: Text(AppLocalizations.of(context)!.purpleSetting),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

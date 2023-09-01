import 'package:flutter/material.dart';
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
    void updateTheme(ThemeMode? themeMode) {
      if (themeMode != null) {
        selectedThemeMode = themeMode;
        context
            .read<ThemeManager>()
            .toggleTheme(themeMode); // Update the theme using the provider
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.appearanceSettingTitle),
        ),
        body: ListView(children: [
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
          )
        ]));
  }
}

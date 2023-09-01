import 'package:flutter/material.dart';
import 'package:foodreviewapp/screens/settings_screens/category_setting_screen.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodreviewapp/utils/display.dart';

class LibrarySettingScreen extends StatefulWidget {
  const LibrarySettingScreen({super.key});

  @override
  State<LibrarySettingScreen> createState() => _LibrarySettingScreenState();
}

class _LibrarySettingScreenState extends State<LibrarySettingScreen> {
  @override
  Widget build(BuildContext context) {
    int selectedDisplayMode = context.watch<DisplayManager>().displayMode;
    void updateDisplayMode(int? displayMode) {
      if (displayMode != null) {
        selectedDisplayMode = displayMode;
        context.read<DisplayManager>().toggleDisplayMode(
            displayMode); // Update the theme using the provider
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.appearanceSettingTitle),
        ),
        body: ListView(children: [
          ListTile(
            leading: const Icon(Icons.tag),
            title: Text(AppLocalizations.of(context)!.categoriesSetting),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CategoriesSettingScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.view_carousel_outlined),
            title: Text(AppLocalizations.of(context)!.displaySetting),
            trailing: DropdownButton(
              value: selectedDisplayMode,
              onChanged: updateDisplayMode,
              items: [
                DropdownMenuItem(
                  value: 0,
                  child: Text(AppLocalizations.of(context)!.cardView),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text(AppLocalizations.of(context)!.listView),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text(AppLocalizations.of(context)!.gridView),
                ),
              ],
            ),
          )
        ]));
  }
}

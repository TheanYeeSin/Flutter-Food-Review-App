import 'package:flutter/material.dart';
import 'package:foodreviewapp/screens/settings_screens/category_setting_screen.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodreviewapp/utils/display.dart';

// Library setting screen
class LibrarySettingScreen extends StatefulWidget {
  const LibrarySettingScreen({super.key});

  @override
  State<LibrarySettingScreen> createState() => _LibrarySettingScreenState();
}

class _LibrarySettingScreenState extends State<LibrarySettingScreen> {
  @override
  Widget build(BuildContext context) {
    int selectedReviewDisplayMode =
        context.watch<DisplayManager>().reviewDisplayMode;
    int selectedCategoryDisplayMode =
        context.watch<DisplayManager>().categoryDisplayMode;

    void updateReviewDisplayMode(int? displayMode) {
      if (displayMode != null) {
        selectedReviewDisplayMode = displayMode;
        context.read<DisplayManager>().toggleReviewDisplayMode(
              displayMode,
            ); // Update the theme using the provider
      }
    }

    void updateCategoryDisplayMode(int? displayMode) {
      if (displayMode != null) {
        selectedCategoryDisplayMode = displayMode;
        context.read<DisplayManager>().toggleCategoryDisplayMode(
              displayMode,
            ); // Update the theme using the provider
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appearanceSettingTitle),
      ),
      body: ListView(
        children: [
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
            title: Text(AppLocalizations.of(context)!.reviewDisplaySetting),
            trailing: DropdownButton(
              value: selectedReviewDisplayMode,
              onChanged: updateReviewDisplayMode,
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
          ),
          ListTile(
            leading: const Icon(Icons.view_array_outlined),
            title: Text(AppLocalizations.of(context)!.categoryDisplaySetting),
            trailing: DropdownButton(
              value: selectedCategoryDisplayMode,
              onChanged: updateCategoryDisplayMode,
              items: [
                DropdownMenuItem(
                  value: 0,
                  child: Text(AppLocalizations.of(context)!.listView),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text(AppLocalizations.of(context)!.gridView),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

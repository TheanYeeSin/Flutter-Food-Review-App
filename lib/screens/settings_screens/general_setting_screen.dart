import 'package:flutter/material.dart';
import 'package:foodreviewapp/utils/language.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GeneralSettingScreen extends StatefulWidget {
  const GeneralSettingScreen({super.key});

  @override
  State<GeneralSettingScreen> createState() => _GeneralSettingScreenState();
}

class _GeneralSettingScreenState extends State<GeneralSettingScreen> {
  @override
  Widget build(BuildContext context) {
    Locale selectedLanguage = context.watch<LanguageManager>().locale;
    void updateLanguage(Locale? locale) {
      if (locale != null) {
        selectedLanguage = locale;
        context
            .read<LanguageManager>()
            .changeLanguage(locale); // Update the theme using the provider
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.generalSettingTitle),
        ),
        body: ListView(children: [
          ListTile(
            leading: const Icon(Icons.translate),
            title: Text(AppLocalizations.of(context)!.languageSetting),
            trailing: DropdownButton(
              value: selectedLanguage,
              onChanged: updateLanguage,
              items: const [
                DropdownMenuItem(
                  value: Locale('en'),
                  child: Text("English"),
                ),
                DropdownMenuItem(
                  value: Locale('zh'),
                  child: Text("中文"),
                ),
              ],
            ),
          )
        ]));
  }
}

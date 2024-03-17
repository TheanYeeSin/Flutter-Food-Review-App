import 'package:flutter/material.dart';
import 'package:foodreviewapp/screens/settings_screens/advanced_setting_screen.dart';
import 'package:foodreviewapp/screens/settings_screens/appearance_setting_screen.dart';
import 'package:foodreviewapp/screens/settings_screens/backup_restore_setting_screen.dart';
import 'package:foodreviewapp/screens/settings_screens/general_setting_screen.dart';
import 'package:foodreviewapp/screens/settings_screens/notification_setting_screen.dart';
import 'package:foodreviewapp/screens/settings_screens/library_setting_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Main Settings Screen that containes other setting screen
class MainSettingsScreen extends StatefulWidget {
  const MainSettingsScreen({super.key});

  @override
  State<MainSettingsScreen> createState() => _MainSettingsScreenState();
}

class _MainSettingsScreenState extends State<MainSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settingsTitle),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.tune),
            title: Text(AppLocalizations.of(context)!.generalSetting),
            subtitle:
                Text(AppLocalizations.of(context)!.generalSettingSubtitle),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GeneralSettingScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: Text(AppLocalizations.of(context)!.appearanceSetting),
            subtitle:
                Text(AppLocalizations.of(context)!.appearanceSettingSubtitle),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppearanceSettingScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.library_books_outlined),
            title: Text(AppLocalizations.of(context)!.librarySetting),
            subtitle:
                Text(AppLocalizations.of(context)!.librarySettingSubtitle),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LibrarySettingScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications_active_outlined),
            title: Text(AppLocalizations.of(context)!.notificationsSetting),
            subtitle: Text(
              AppLocalizations.of(context)!.notificationsSettingSubtitle,
            ),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationSettingScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.backup_outlined),
            title: Text(AppLocalizations.of(context)!.backupRestoreSetting),
            subtitle: Text(
              AppLocalizations.of(context)!.backupRestoreSettingSubtitle,
            ),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BackupRestoreSettingScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.code),
            title: Text(AppLocalizations.of(context)!.advancedSetting),
            subtitle:
                Text(AppLocalizations.of(context)!.advancedSettingSubtitle),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdvancedSettingScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:foodreviewapp/screens/settings_screens/backup_restore_setting_screen.dart';
import 'package:foodreviewapp/screens/settings_screens/category_setting_screen.dart';
import 'package:foodreviewapp/screens/settings_screens/main_settings_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Theme.of(context).brightness == Brightness.light
                        ? Image.asset('assets/icons/logo.png')
                        : Image.asset('assets/icons/logo_white.png')),
              ),
              const Divider(height: 4, thickness: 2),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.tag),
                      title:
                          Text(AppLocalizations.of(context)!.categoriesSetting),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const CategoriesSettingScreen(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.backup),
                      title: Text(
                          AppLocalizations.of(context)!.backupRestoreSetting),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const BackupRestoreSettingScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 4, thickness: 2),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: Text(AppLocalizations.of(context)!.setting),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainSettingsScreen(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.info),
                      title: Text(AppLocalizations.of(context)!.about),
                      onTap: () async {
                        final url = Uri.parse(
                            'https://github.com/TheanYeeSin/Tabemashou-Food-Review-App');
                        if (!await launchUrl(url,
                            mode: LaunchMode.externalApplication)) {
                          throw Exception('Could not launch $url');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:foodreviewapp/database/database_service.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Advanced setting screen
class AdvancedSettingScreen extends StatefulWidget {
  const AdvancedSettingScreen({super.key});

  @override
  State<AdvancedSettingScreen> createState() => _AdvancedSettingScreenState();
}

class _AdvancedSettingScreenState extends State<AdvancedSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.advancedSettingTitle),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.delete_forever_outlined),
            title: Text(AppLocalizations.of(context)!.deleteDatabaseSetting),
            trailing: const Icon(Icons.chevron_right_outlined),
            onTap: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Center(
                      child: Text(
                        AppLocalizations.of(context)!.deleteDatabaseDialogTitle,
                      ),
                    ),
                    content: Text(
                      AppLocalizations.of(context)!.deleteDatabaseDialogMessage,
                    ),
                    actions: [
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(AppLocalizations.of(context)!.no),
                          ),
                          TextButton(
                            onPressed: () async {
                              DatabaseService.deleteDatabase();
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);

                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    // ignore: use_build_context_synchronously
                                    AppLocalizations.of(context)!
                                        .deleteDatabaseSuccessSnackbar,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  backgroundColor: Colors.green[100],
                                ),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)!.yes,
                              style: const TextStyle(
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

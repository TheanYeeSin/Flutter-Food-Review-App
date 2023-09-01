import 'package:flutter/material.dart';
import 'package:foodreviewapp/database/database_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:io';

class BackupRestoreSettingScreen extends StatefulWidget {
  const BackupRestoreSettingScreen({super.key});

  @override
  State<BackupRestoreSettingScreen> createState() =>
      _BackupRestoreSettingScreenState();
}

class _BackupRestoreSettingScreenState
    extends State<BackupRestoreSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.backupRestoreSetting),
        ),
        body: ListView(children: [
          ListTile(
            leading: const Icon(Icons.backup_outlined),
            title: Text(AppLocalizations.of(context)!.backupSetting),
            subtitle: Text(AppLocalizations.of(context)!.backupSettingSubtitle),
            trailing: const Icon(Icons.chevron_right_outlined),
            onTap: () async {
              try {
                DatabaseService.backupDatabase();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    // ignore: use_build_context_synchronously
                    AppLocalizations.of(context)!.backUpSuccessSnackbar(
                        "/storage/emulated/0/Tabemashou Backup"),
                    style: const TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.green[100],
                ));
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    // ignore: use_build_context_synchronously
                    AppLocalizations.of(context)!
                        .backUpFailedSnackbar(e.toString()),
                    style: const TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.red[100],
                ));
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.restore),
            title: Text(AppLocalizations.of(context)!.restoreSetting),
            subtitle:
                Text(AppLocalizations.of(context)!.restoreSettingSubtitle),
            trailing: const Icon(Icons.chevron_right_outlined),
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();
              if (result != null) {
                File file = File(result.files.single.path!);
                if (await DatabaseService.isValidDatabaseFile(file)) {
                  DatabaseService.restoreDatabase(file);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      // ignore: use_build_context_synchronously
                      AppLocalizations.of(context)!.restoreSuccessSnackbar,
                      style: const TextStyle(color: Colors.black),
                    ),
                    backgroundColor: Colors.green[100],
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      // ignore: use_build_context_synchronously
                      AppLocalizations.of(context)!.restoreFailedSnackbar,
                      style: const TextStyle(color: Colors.black),
                    ),
                    backgroundColor: Colors.red[100],
                  ));
                }
              }
            },
          )
        ]));
  }
}

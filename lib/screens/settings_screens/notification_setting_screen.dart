import 'package:flutter/material.dart';
import 'package:foodreviewapp/utils/notification.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({super.key});

  @override
  State<NotificationSettingScreen> createState() =>
      _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  late SharedPreferences _prefs;
  TimeOfDay selectedBreakfastTime = TimeOfDay.now();
  TimeOfDay selectedLunchTime = TimeOfDay.now();
  TimeOfDay selectedDinnerTime = TimeOfDay.now();
  bool breakfastSwitchValue = true;
  bool lunchSwitchValue = true;
  bool dinnerSwitchValue = true;
  @override
  void initState() {
    super.initState();
    _loadSavedValues();
  }

  Future<void> _loadSavedValues() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedBreakfastTime = _getSavedTime('breakfastTime') ?? TimeOfDay.now();
      selectedLunchTime = _getSavedTime('lunchTime') ?? TimeOfDay.now();
      selectedDinnerTime = _getSavedTime('dinnerTime') ?? TimeOfDay.now();
      breakfastSwitchValue = _getSavedSwitch('breakfastSwitch') ?? true;
      lunchSwitchValue = _getSavedSwitch('lunchSwitch') ?? true;
      dinnerSwitchValue = _getSavedSwitch('dinnerSwitch') ?? true;
    });
  }

  TimeOfDay? _getSavedTime(String key) {
    final String? savedTime = _prefs.getString(key);
    if (savedTime != null) {
      final List<String> timeParts = savedTime.split(':');
      return TimeOfDay(
        hour: int.parse(timeParts[0]),
        minute: int.parse(timeParts[1]),
      );
    }
    return null;
  }

  bool? _getSavedSwitch(String key) {
    return _prefs.getBool(key);
  }

  Future<void> _saveTime(String key, TimeOfDay timeOfDay) async {
    await _prefs.setString(
      key,
      '${timeOfDay.hour}:${timeOfDay.minute}',
    );
  }

  Future<void> _saveSwitch(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

// Inside each onChanged method for the switches

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.notificationsSettingTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(AppLocalizations.of(context)!
                        .notificationTooltipDialogTitle),
                    content: Text(AppLocalizations.of(context)!
                        .notificationTooltipDialogMessage),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(AppLocalizations.of(context)!.okay),
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
      body: ListView(
        children: [
          //=====Breakfast=====
          ListTile(
            leading: const Icon(Icons.free_breakfast_outlined),
            title: Text(AppLocalizations.of(context)!.breakfastSetting),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton(
                    onPressed: () async {
                      final TimeOfDay? timeOfDay = await showTimePicker(
                        context: context,
                        initialTime: selectedBreakfastTime,
                        initialEntryMode: TimePickerEntryMode.dial,
                      );
                      if (timeOfDay != null) {
                        setState(() {
                          selectedBreakfastTime = timeOfDay;
                        });
                        if (breakfastSwitchValue) {
                          NotificationManager.cancelNotification(111);
                          NotificationManager.scheduleDailyNotification(
                            111,
                            selectedBreakfastTime,
                            AppLocalizations.of(context)!
                                .breakfastNotificationTitle,
                            AppLocalizations.of(context)!
                                .breakfastNotificationMessage,
                          );
                        }
                        _saveTime('breakfastTime', timeOfDay);
                      }
                    },
                    child: Text(
                        "${selectedBreakfastTime.hour}:${selectedBreakfastTime.minute}")),
                Switch(
                  value: breakfastSwitchValue,
                  onChanged: (value) {
                    setState(() {
                      breakfastSwitchValue = value;
                    });
                    if (value) {
                      NotificationManager.scheduleDailyNotification(
                        111,
                        selectedBreakfastTime,
                        AppLocalizations.of(context)!
                            .breakfastNotificationTitle,
                        AppLocalizations.of(context)!
                            .breakfastNotificationMessage,
                      );
                    } else {
                      NotificationManager.cancelNotification(111);
                    }
                    _saveSwitch('breakfastSwitch', value);
                  },
                ),
              ],
            ),
          ),
          //=====Lunch=====
          ListTile(
            leading: const Icon(Icons.lunch_dining_outlined),
            title: Text(AppLocalizations.of(context)!.lunchSetting),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton(
                    onPressed: () async {
                      final TimeOfDay? timeOfDay = await showTimePicker(
                        context: context,
                        initialTime: selectedLunchTime,
                        initialEntryMode: TimePickerEntryMode.dial,
                      );
                      if (timeOfDay != null) {
                        setState(() {
                          selectedLunchTime = timeOfDay;
                        });
                        if (lunchSwitchValue) {
                          NotificationManager.cancelNotification(222);
                          NotificationManager.scheduleDailyNotification(
                            222,
                            selectedLunchTime,
                            AppLocalizations.of(context)!
                                .lunchNotificationTitle,
                            AppLocalizations.of(context)!
                                .lunchNotificationMessage,
                          );
                        }
                        _saveTime('lunchTime', timeOfDay);
                      }
                    },
                    child: Text(
                        "${selectedLunchTime.hour}:${selectedLunchTime.minute}")),
                Switch(
                  value: lunchSwitchValue,
                  onChanged: (value) {
                    setState(() {
                      lunchSwitchValue = value;
                    });

                    if (value) {
                      NotificationManager.scheduleDailyNotification(
                        222,
                        selectedLunchTime,
                        AppLocalizations.of(context)!.lunchNotificationTitle,
                        AppLocalizations.of(context)!.lunchNotificationMessage,
                      );
                    } else {
                      NotificationManager.cancelNotification(222);
                    }
                    _saveSwitch('lunchSwitch', value);
                  },
                ),
              ],
            ),
          ),
          //=====Dinner=====
          ListTile(
            leading: const Icon(Icons.dinner_dining_outlined),
            title: Text(AppLocalizations.of(context)!.dinnerSetting),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton(
                    onPressed: () async {
                      final TimeOfDay? timeOfDay = await showTimePicker(
                        context: context,
                        initialTime: selectedDinnerTime,
                        initialEntryMode: TimePickerEntryMode.dial,
                      );
                      if (timeOfDay != null) {
                        setState(() {
                          selectedDinnerTime = timeOfDay;
                        });
                        if (dinnerSwitchValue) {
                          NotificationManager.cancelNotification(333);
                          NotificationManager.scheduleDailyNotification(
                            333,
                            selectedDinnerTime,
                            AppLocalizations.of(context)!
                                .dinnerNotificationTitle,
                            AppLocalizations.of(context)!
                                .dinnerNotificationMessage,
                          );
                        }
                        _saveTime('dinnerTime', timeOfDay);
                      }
                    },
                    child: Text(
                        "${selectedDinnerTime.hour}:${selectedDinnerTime.minute}")),
                Switch(
                  value: dinnerSwitchValue,
                  onChanged: (value) {
                    setState(() {
                      dinnerSwitchValue = value;
                    });

                    if (value) {
                      NotificationManager.scheduleDailyNotification(
                        333,
                        selectedDinnerTime,
                        AppLocalizations.of(context)!.dinnerNotificationTitle,
                        AppLocalizations.of(context)!.dinnerNotificationMessage,
                      );
                    } else {
                      NotificationManager.cancelNotification(333);
                    }
                    _saveSwitch('dinnerSwitch', value);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

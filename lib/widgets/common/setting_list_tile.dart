import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SettingListTile extends StatelessWidget {
  final Widget leadingIcon;
  final String title;
  final VoidCallback? onTap;
  const SettingListTile(
      {super.key, required this.leadingIcon, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(leading: leadingIcon, title: Text(title), onTap: onTap);
  }
}

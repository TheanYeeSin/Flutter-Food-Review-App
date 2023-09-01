import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayManager extends ChangeNotifier {
  // 0 - card view
  // 1 - list view
  // 2 - grid view
  static int _displayMode = 0;

  int get displayMode => _displayMode;

  DisplayManager() {
    _loadSavedDisplayMode();
  }

  Future<void> _loadSavedDisplayMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedDisplayMode = prefs.getInt('displayMode') ?? 0;
    _displayMode = savedDisplayMode;
    notifyListeners();
  }

  toggleDisplayMode(int displayMode) async {
    _displayMode = displayMode;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('displayMode', displayMode);
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayManager extends ChangeNotifier {
  // Review Listing Screen - Review
  // 0 - card view
  // 1 - list view
  // 2 - grid view
  static int _reviewDisplayMode = 0;

  // Main Listing Screen - Category
  // 0 - list view
  // 1 - grid view
  static int _categoryDisplayMode = 0;

  int get reviewDisplayMode => _reviewDisplayMode;
  int get categoryDisplayMode => _categoryDisplayMode;

  DisplayManager() {
    _loadSavedDisplayMode();
  }

  Future<void> _loadSavedDisplayMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedReviewDisplayMode = prefs.getInt('reviewDisplayMode') ?? 0;
    int savedCategoryDisplayMode = prefs.getInt('categoryDisplayMode') ?? 0;
    _reviewDisplayMode = savedReviewDisplayMode;
    _categoryDisplayMode = savedCategoryDisplayMode;
    notifyListeners();
  }

  toggleReviewDisplayMode(int reviewDisplayMode) async {
    _reviewDisplayMode = reviewDisplayMode;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('reviewDisplayMode', reviewDisplayMode);
  }

  toggleCategoryDisplayMode(int categoryDisplayMode) async {
    _categoryDisplayMode = categoryDisplayMode;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('categoryDisplayMode', categoryDisplayMode);
  }
}

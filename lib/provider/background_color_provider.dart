import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';

final darkmodeProvider = ChangeNotifierProvider<BackGroundColor>((ref) {
  return BackGroundColor();
});

class BackGroundColor extends ChangeNotifier {
  bool isDarkModeEnabled = false;

  void setLightTheme() {
    isDarkModeEnabled = false;
    notifyListeners();
  }

  void setDarkTheme() {
    isDarkModeEnabled = true;
    notifyListeners();
  }
}

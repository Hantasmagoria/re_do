import 'package:flutter/material.dart';

class AppStateNotifier extends ChangeNotifier {
  bool isDark = false;

  void switchTheme(bool isDark) {
    this.isDark = isDark;
    notifyListeners();
  }
}
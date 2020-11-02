import 'package:flutter/material.dart';

class AppStateNotifier with ChangeNotifier {
  bool isDark = false;
  bool isEdit = false;

  void switchTheme(String modeSelect) {
    switch (modeSelect){
      case 'darkSwitch':{
        this.isDark = !this.isDark;
        break;
      }
      default:{
        print('abnormal switch case for switchTheme');
        break;
      }
    }
    notifyListeners();
  }

  void switchEditMode() {
    this.isEdit = !this.isEdit;
    notifyListeners();
  }
}
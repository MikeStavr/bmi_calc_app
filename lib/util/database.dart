import 'package:hive_flutter/hive_flutter.dart';

class Database {
  List bmis = [];
  final bmiBox = Hive.box('bmi');

  void loadData() {
    bmis = bmiBox.get("BMIDATA");
  }

  void updateData() {
    bmiBox.put("BMIDATA", bmis);
  }

  List settings = [
    "Dark Mode",
    "About",
  ];

  final settingsBox = Hive.box('settings');

  void loadSettings() {
    settings = settingsBox.get("SETTINGS");
  }

  void updateSettings() {
    settingsBox.put("SETTINGS", settings);
  }
}

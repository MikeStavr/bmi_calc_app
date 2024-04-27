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
}

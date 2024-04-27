import 'package:app_bmi_calculator/main.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final settingsBox = Hive.box('settings');
  List settings = [
    ["Dark Mode", false],
  ];

  @override
  void initState() {
    settings = settingsBox.get("SETTINGS", defaultValue: []);
    super.initState();
  }

  void saveBox() {
    settingsBox.put("SETTINGS", settings);
  }

  void updateValue(index, value) {
    setState(() {
      settings[index][1] = value;
      if (settings[index][1]) {
        MyApp.of(context).changeTheme(ThemeMode.dark);
        saveBox();
      } else {
        MyApp.of(context).changeTheme(ThemeMode.light);
        saveBox();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue[600],
        title: const Text("Settings"),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: settings.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(settings[index][0]),
              trailing: Switch(
                value: settings[index][1],
                onChanged: (value) => {updateValue(index, value)},
              ),
            );
          },
        ),
      ),
    );
  }
}

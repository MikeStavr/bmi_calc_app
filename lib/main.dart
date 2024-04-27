// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'screens/history_page.dart';
import 'package:app_bmi_calculator/screens/home_page.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox('bmi');
  await Hive.openBox('settings');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      title: 'Flutter Demo',
      home: HomePage(),
      routes: {
        '/homepage': (context) => HomePage(),
        '/historypage': (context) => HistoryPage(),
      },
    );
  }
}

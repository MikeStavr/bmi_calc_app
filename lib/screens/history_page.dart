// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final bmiBox = Hive.box('bmi');

  void updateData(index, context) {
    setState(() {
      bmiBox.get("BMIDATA", defaultValue: []).removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue[600],
          title: const Text("History"),
        ),
        body: ListView.builder(
          itemCount: bmiBox.get("BMIDATA", defaultValue: []).length,
          itemBuilder: (context, index) {
            return Slidable(
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      updateData(index, context);
                      // delete current list item
                    },
                    icon: Icons.delete,
                    label: 'Delete',
                    backgroundColor: Colors.red,
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                    style: TextStyle(fontWeight: FontWeight.bold),
                    "Weight: ${bmiBox.get("BMIDATA", defaultValue: [])[index][0]} kg"),
                subtitle: Text(
                    "Height: ${bmiBox.get("BMIDATA", defaultValue: [])[index][1]} cm"),
                trailing: Text(
                    "BMI: ${bmiBox.get("BMIDATA", defaultValue: [])[index][2]} - ${bmiBox.get("BMIDATA", defaultValue: [])[index][3]}"),
              ),
            );
          },
        ));
  }
}

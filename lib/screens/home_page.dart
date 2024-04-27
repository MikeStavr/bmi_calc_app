// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  final bmiBox = Hive.box('bmi');
  List bmis = [];

  double userBMI = 0;
  String bmiResult = '';
  @override
  void initState() {
    bmis = bmiBox.get("BMIDATA", defaultValue: []);
    super.initState();
  }

  void saveData() {
    bmiBox.put("BMIDATA", bmis);
  }

  void calculateBMI() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    setState(() {
      userBMI = weight / (height * height);

      if (userBMI < 18.5) {
        bmiResult = 'Underweight';
      } else if (userBMI >= 18.5 && userBMI <= 24.9) {
        bmiResult = 'Normal weight';
      } else if (userBMI >= 25 && userBMI <= 29.9) {
        bmiResult = 'Overweight';
      } else if (userBMI >= 30 && userBMI <= 39.9) {
        bmiResult = 'Obesity';
      } else {
        bmiResult = 'Morbid Obesity';
      }
      bmis.add([weight, height, userBMI, bmiResult]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue[600],
          title: Text("BMI Calculator"),
        ),
        drawer: Drawer(
          backgroundColor: Colors.blue,
          child: Column(
            children: [
              DrawerHeader(
                  child: Icon(
                Icons.scale,
                color: Colors.white,
                size: 100,
              )),
              ListTile(
                iconColor: Colors.white,
                textColor: Colors.white,
                title: Text('Home'),
                leading: Icon(Icons.home),
                onTap: () => {
                  Navigator.pop(context),
                  Navigator.pushNamed(context, '/homepage')
                },
              ),
              ListTile(
                iconColor: Colors.white,
                textColor: Colors.white,
                title: Text('History'),
                leading: Icon(Icons.auto_graph),
                onTap: () => {
                  Navigator.pop(context),
                  Navigator.pushNamed(context, '/historypage')
                },
              ),
              ListTile(
                iconColor: Colors.white,
                textColor: Colors.white,
                title: Text('Settings'),
                leading: Icon(Icons.settings),
                onTap: () => {
                  Navigator.pop(context),
                  Navigator.pushNamed(context, '/settingspage')
                },
              )
            ],
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Your BMI is: ${userBMI == 0 ? ' ' : userBMI.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: weightController,
                    decoration: InputDecoration(
                        labelText: 'Enter your weight in kg',
                        hintText: 'Weight in kg',
                        icon: Icon(Icons.monitor_weight),
                        border: OutlineInputBorder()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: heightController,
                    decoration: InputDecoration(
                        labelText: 'Enter your height in cm',
                        hintText: 'Height in cm',
                        icon: Icon(Icons.height),
                        border: OutlineInputBorder()),
                  ),
                ),
                Wrap(children: [
                  ElevatedButton(
                    onPressed: () {
                      calculateBMI();
                    },
                    child: Text('Calculate BMI'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        saveData();
                      },
                      child: Text('Save BMI'))
                ]),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Table(
                    children: [
                      TableRow(children: [
                        Text(
                          'BMI Category',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'BMI Range',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ]),
                      TableRow(children: [
                        Text('Underweight'),
                        Text('< 18.5'),
                      ]),
                      TableRow(children: [
                        Text('Normal weight'),
                        Text('18.5 - 24.9'),
                      ]),
                      TableRow(children: [
                        Text('Overweight'),
                        Text('25 - 29.9'),
                      ]),
                      TableRow(children: [
                        Text('Obesity'),
                        Text('30 - 39.9'),
                      ]),
                      TableRow(children: [
                        Text('Morbid Obesity'),
                        Text('>= 40'),
                      ]),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

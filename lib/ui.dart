import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fooddataagg/firebase.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Who....cares',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: "title"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FireBaseDB db = FireBaseDB();
  double _currentSliderValue = 20;

  void circleButtonPress(double weight) {
    db.testSet(weight);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: "Statistics"),
                Tab(text: "Settings"),
                Tab(text: "Control"),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              Text("Stats placeholder"),
              Icon(Icons.directions_transit),
              Column(children: [
                Padding(
                    padding: EdgeInsets.only(top: 200.0, bottom: 50.0),
                    child: Expanded(
                      child: ElevatedButton(
                        onPressed: () => (circleButtonPress(_currentSliderValue)),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(75),
                          backgroundColor: Colors.blue, // <-- Button color
                          foregroundColor: Colors.white, // <-- Splash color),)
                        ),
                        child: const Text("Feed now"),
                      ),
                    )),
                Column(children: [
                  const Text("Choose amount"),
                  Slider(
                    value: _currentSliderValue,
                    max: 200,
                    divisions: 40,
                    label: "${_currentSliderValue.round()}g",
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                    },
                  ),
                ]),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fooddataagg/command.dart';
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
  List<Command> _commands = [];
  double _currentSliderValue = 20;
  double _intervalSliderValue = 3;
  double _delaySliderValue = 8;
  double _amountSliderValue = 20;
  dynamic _value = 0;

  void circleButtonPress(String buttonText) {
    setState(() {
      Command? command = null;
      switch (buttonText) {
        case "Feed now":
          command = instantFeedCommand();
          _value = _currentSliderValue;
          break;
        case "Save settings":
          command = instantFeedCommand();
          _value = _intervalSliderValue;
          _value = _delaySliderValue;
          _value = _amountSliderValue;
          break;
      }
      if (command != null) {
        command.execute(_value);
        _commands.add(command);
      }
    });
  }

  Widget roundButton(String buttonText, double size) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => (circleButtonPress(buttonText)),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(size),
          backgroundColor: Colors.blue, // <-- Button color
          foregroundColor: Colors.white, // <-- Splash color),)
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget statisticsTab() {
    return Column(children: [
      const SizedBox(
        height: 75,
      ),
      Column(children: [
        const Text('Amount of food given today:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        const Text('Placeholder', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        Divider(),
        const SizedBox(height: 5),
        const Text('The average amount of food each week:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        const Text('Placeholder', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        Divider(),
        const SizedBox(height: 5),
        const Text('Undereating or overeating:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        const Text('Placeholder', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        Divider(),
        const SizedBox(height: 5),
        const Text('Refill status:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        const Text('Placeholder', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        Divider(),
        const SizedBox(height: 5),
      ]),
    ]);
  }

  Widget controlTab() {
    return Column(children: [
      Padding(
          padding: EdgeInsets.only(top: 200.0, bottom: 50.0),
          child: roundButton("Feed now", 90)),
      Column(children: [
        const Text("Choose amount"),
        Slider(
          value: _currentSliderValue,
          max: 50,
          divisions: 10,
          label: "${_currentSliderValue.round()}g",
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
          },
        ),
      ]),
    ]);
  }

  Widget settingsTab() {
    return Column(children: [
      const SizedBox(
        height: 75,
      ),
      Column(children: [
        const Text(
          "Times a day:",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Slider(
          value: _intervalSliderValue,
          max: 7,
          divisions: 7,
          label: "${_intervalSliderValue.round()} intervals a day",
          onChanged: (double value) {
            setState(() {
              _intervalSliderValue = value;
            });
          },
        ),
        const Text(
          "How many hours in between:",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Slider(
          value: _delaySliderValue,
          max: 24,
          divisions: 24,
          label: "Every ${_delaySliderValue.round()} hours a day",
          onChanged: (double value) {
            setState(() {
              _delaySliderValue = value;
            });
          },
        ),
        const Text(
          "Amount of food:",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Slider(
          value: _amountSliderValue,
          max: 50,
          divisions: 25,
          label: "${_amountSliderValue.round()} amount each interval",
          onChanged: (double value) {
            setState(() {
              _amountSliderValue = value;
            });
          },
        ),
      ]),
      roundButton("Save settings", 50)
    ]);
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
            title: const Text('Feeder 9000'),
          ),
          body: TabBarView(children: [
            statisticsTab(),
            settingsTab(),
            controlTab(),
          ]),
        ),
      ),
    );
  }
}

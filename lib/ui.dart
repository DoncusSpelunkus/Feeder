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
  double _settingSliderValue = 3;
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
          _value = _settingSliderValue;
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

  Widget controlTab() {
    return Column(children: [
      Padding(
          padding: EdgeInsets.only(top: 200.0, bottom: 50.0),
          child: roundButton("Feed now", 90)),
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
    ]);
  }

  Widget settingsTab() {
    return Column(children: [
      const SizedBox(
        height: 200,
      ),
      Column(children: [
        const Text("Interval",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        Slider(
      value: _settingSliderValue,
      max: 10,
      divisions: 10,
      label: "${_settingSliderValue.round()} times a day",
      onChanged: (double value) {
        setState(() {
          _settingSliderValue = value;
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
            title: const Text('Tabs Demo'),
          ),
          body: TabBarView(children: [
            Text("Stats placeholder"),
            settingsTab(),
            controlTab(),
          ]),
        ),
      ),
    );
  }
}

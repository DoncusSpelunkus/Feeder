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

  void onButtonPress(){
    db.testSet();
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: SizedBox(
        height: 70.0,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: OutlinedButton(
            child: Text(
              buttonText,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => (onButtonPress()),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column( children: [
        Container(
          child: Row(
            children: [
              buildButton("Statistics"),
              buildButton("Settings"),
              buildButton("Control")
             ],
            )
          )
        ]
      ),
    );
  }
}
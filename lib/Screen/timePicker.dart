import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimePicker extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _timePicker();
}

class _timePicker extends State<TimePicker>{
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Make a new timeslot"),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _selectTime,
                child: Text('SELECT TIME'),
              ),
              SizedBox(height: 8),
              DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: const BoxDecoration(
              ),
                child: Text(
                  'Selected time: ${_time.format(context)}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: new InputDecoration(labelText: "Enter weight"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ],
          )
        )
      );
  }}
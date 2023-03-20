import 'package:flutter/material.dart';
import 'package:fooddataagg/Screen/timePicker.dart';
import 'package:table_calendar/table_calendar.dart';

class SettingsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar - Basics'),
      ),
      body: CustomScrollView(
        slivers: [
            SliverToBoxAdapter(child: Calendar()),
            SliverToBoxAdapter(child: BuildScheduleBtn()),
         ]
      )
    );
  }
}

class Calendar extends StatefulWidget{
  const Calendar({super.key});

  @override
  State<StatefulWidget> createState() => _Calender();
}

class _Calender extends State<Calendar>{
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            // Call `setState()` when updating the selected day
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            // Call `setState()` when updating calendar format
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          // No need to call `setState()` here
          _focusedDay = focusedDay;
        },
      );
  }
}

class BuildScheduleBtn extends StatefulWidget{
  const BuildScheduleBtn({super.key});

  @override
  State<StatefulWidget> createState() => _BuildScheduleBtn();

}

class _BuildScheduleBtn extends State<BuildScheduleBtn>{
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context)=> TimePicker(

              )));
        },
        child: Text("Make new time on the selected day")
    );
  }
}
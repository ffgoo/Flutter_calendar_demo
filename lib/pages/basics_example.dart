import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


import 'package:untitled2/utils.dart';




class TableBasicExample extends StatefulWidget {
  @override
  _TableBasicExampleState createState() => _TableBasicExampleState();
}

class _TableBasicExampleState extends State<TableBasicExample> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Basic Calendar'),
      ),
      body: TableCalendar(
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day){
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay){
          if(!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },
        onFormatChanged: (format){
          if(_calendarFormat != format){
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay){
          _focusedDay = focusedDay;
        },  
      ),
    );
  }
} 
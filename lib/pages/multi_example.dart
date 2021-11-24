import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils.dart';


class TableMultiExample extends StatefulWidget{

}

class _TableMultiExampleState extends State<TableMultiExample>{
  final ValueNotifier<List<Event>> _selectedEvents = ValueNotifier([]);

  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  @override
  void dispose(){
    _selectedEvents.dispose();
    super.dispose();

  }

  List<Event> _getEventsForDay(DateTime day){
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForDays(Set<DateTime> days){
    return [
      for (final d in days) ..._getEventsForDay(d)
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay){
    setState(() {
      _focusedDay = focusedDay;

      if(_selectedDays.contains(selectedDay)){
        _selectedDays.remove(selectedDay);
      }else{
        _selectedDays.add(selectedDay);
      }
    });
    _selectedEvents.value = _getEventsForDays(_selectedDays);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar - Multi'),
      ),
      body: Column(
        children: [
          TableCalendar(
              focusedDay: _focusedDay,
              firstDay: kFirstDay,
              lastDay: kLastDay,
              calendarFormat: _calendarFormat,
              eventLoader: _getEventsForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              selectedDayPredicate: (day){
                return _selectedDays.contains(day);
              },
            onDaySelected: _onDaySelected,
            onFormatChanged: (format){
                if(_calendarFormat != format){
                  setState(() {
                    _calendarFormat = format;
                  });
                }
            },
            onPageChanged: (focusDay){
                _focusedDay = focusDay;
            },
          ),
          ElevatedButton(
              child: Text('Clear Selection'),
            onPressed:(){
                setState(() {
                  _selectedDays.clear();
                  _selectedEvents.value = [];
                });
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
              child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder :(context , value, _){
                  return ListView.builder(
                    itemCount: value.length,
                    itemBuilder: (context, index){
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(),
                        ),
                        child: ListTile(
                          onTap: () => print('${value[index]}'),
                          title: Text('${value[index]}'),


                        ),
                      );
                    },
                  );
                },
              ),
          ),
        ],
      ),
    );
  }
}


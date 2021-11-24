import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils.dart';


class TableEventsExample extends StatefulWidget{
  @override
  _TableeventsExampleState createState() => _TableeventsExampleState();
}

class _TableeventsExampleState extends State<TableEventsExample>{
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeselectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState(){
    super.initState();

    _selectedDay = _focusDay;
    // _selectedEvents = ValueNotifier(_getEve)

  }

  @override
  void dispose(){
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day){
    return kEvents[day] ?? [];
  }


  List<Event> _getEventsForRange(DateTime start , DateTime end){
    final days = daysInRange(start, end);

    return[
      for(final d in days) ..._getEventsForDay(d)
    ];

  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if(!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeselectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay){
    setState(() {
      _selectedDay = null;
      _focusDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeselectionMode = RangeSelectionMode.toggledOn;
    });

    if(start != null && end != null ) {
      _selectedEvents.value = _getEventsForRange(start, end);
    }else if (start != null){
      _selectedEvents.value = _getEventsForDay(start);
    }else if (end != null){
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar - Events'),
      ),
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay:  _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeselectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format){
              if(_calendarFormat != format){
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay){
              _focusDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
              child: ValueListenableBuilder<List<Event>>(
               valueListenable: _selectedEvents,
               builder: (context, value, _){
                 return ListView.builder(
                    itemCount: value.length,
                     itemBuilder: (context, index){
                      return Container(
                        margin : const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          border:Border.all(),
                          borderRadius: BorderRadius.circular(12.0),
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



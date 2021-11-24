import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';


class Event {
  final String title;

  const Event(this.title)

  @override
  String toString() => title;
}


final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
  key: (item) => DateTime.utc(kFirstDay.year,kFirstDay.month,item * 5),
  value: (item) => List.generate(
    item % 4 + 1 (index) => Event('Event $item | ')))




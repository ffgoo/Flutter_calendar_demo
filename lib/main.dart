import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'TableCalendar Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartPage(),
    );
  }
}


class StartPage extends StatefulWidget{
  @override
  _StartPageState createState() => _StartPageState()
}

class _StartPageState extends State<StartPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('TableCalendar Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0),
            ElevatedButton(
              child: Text('Basics'),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => TableBasicsExample()),
                ),
            ),
            const SizedBox(height : 12.0),
            ElevatedButton(
              child: Text('Range Selection'),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => TableRangeExample())),
            ),
            const SizedBox(height : 12.0),
            ElevatedButton(
              child: Text('Events'),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => TableEventExample())),
            ),
            const SizedBox(height : 12.0),
            ElevatedButton(
              child: Text('Multiple Selection'),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => TableComplexExample())),
            ),
            const SizedBox(height : 12.0),
            ElevatedButton(
              child: Text('Complex'),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => TableRangeExample())),
            ),
            const SizedBox(height : 20.0),
          ],
        ),
      ),
    )
  }
}


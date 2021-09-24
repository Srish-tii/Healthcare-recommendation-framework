import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'Activities.dart';
// ------------------------- Set time of practicing and select activities  ----------------------
class Activities  extends StatelessWidget{
 // ---------------------  Meeting means time to start practicing next time ------------------
  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Activities ')),
        body:SafeArea(
            child: SingleChildScrollView(
            child :Padding (
            padding: const EdgeInsets.all(20.0),
                child: Form(
                  child : Column (
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                  IconButton( icon:Icon(Icons.home , color:Theme.of(context).primaryColor),
                  onPressed: (){Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> MyApp())); },
                ),
                      SizedBox(height : 10),
                      Padding(
                      padding: const EdgeInsets.all(3.0),
                        child : Row(
                          children: [
                            Expanded(
                              child: Text('Select your Time,'
                                  'To start practicing ', textAlign: TextAlign.center ,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(1.0)),
                            ),),
                            Expanded(
                            child : SfCalendar(
                               view :CalendarView.month,
                              dataSource: MeetingDataSources(_getDataSource()),
                              monthViewSettings: const MonthViewSettings(
                                  appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
                            )
                            ),
                          ],  ),
                      ),
                        SizedBox(width: 20,),
                        Padding(padding: const EdgeInsets.all(10.0),
                          child : Row(
                              children: [
                          Expanded(
                          child: Text('Choose activities you want to practice ,'
                              '', textAlign: TextAlign.center ,
                            style: TextStyle(fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(1.0)),),
                        ),
                                TextButton(onPressed: () {Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=> SelectActivity()));
                                },
                                  child: Text("Select your activity "),),],),),
                        SizedBox(height: 20),
                              ],),
                        ),

        ),),),
    );}
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

// ----- Creates a meeting data source, which used to set the appointment collection to the calendar----
class MeetingDataSources extends CalendarDataSource {
  MeetingDataSources(List<Meeting> getDataSource);

  //MeetingDataSources(getDataSource);
  // ignore: non_constant_identifier_names
  MeetingDataSource(List<Meeting> source) {
  appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
  return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
  return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
  return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
  return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
  return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
  final dynamic meeting = appointments![index];
  late final Meeting meetingData;
  if (meeting is Meeting) {
  meetingData = meeting;
  }

  return meetingData;
  }
  }

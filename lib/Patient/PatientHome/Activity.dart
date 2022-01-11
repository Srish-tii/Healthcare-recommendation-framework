import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rastreador/Patient/PatientHome/PractTime.dart';
import '../../main.dart';
import 'AddAct.dart';
import 'ListActivities.dart';


/// ------------------------- Set time of practicing and select activities  ----------------------
class Activities  extends StatefulWidget {
  _activities createState ()=> _activities() ;
}
class _activities extends State <Activities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Practicing Home')),
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
                    child: Text('Select Time,'
                        'To start practicing ', textAlign: TextAlign.center ,
                      style: TextStyle(fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(1.0)),
                    ),),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child :SizedBox(height: 500, width: 335,
                    child :Text('Select practicing Time,'
                        '', textAlign: TextAlign.center ,
                      style: TextStyle(fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(1.0)),),
                    ) , ),
                  TextButton(onPressed: () {Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> PractTime()));
                  },
                      child: Text("Select time ")),
                  /* SfCalendar(
                               view :CalendarView.month,
                              dataSource: PracticingDataSources(_getDataSource()),
                              monthViewSettings: const MonthViewSettings(
                                  appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
                            )*/

                  SizedBox(width: 20,),
                  Padding(padding: const EdgeInsets.all(10.0),
                    child : Row(
                      children: [
                        Expanded(
                          child: Text('Add your activity ,'
                              '', textAlign: TextAlign.center ,
                            style: TextStyle(fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(1.0)),),
                        ),
                        TextButton(onPressed: () {Navigator.push(context,
                            MaterialPageRoute(builder: (context)=> WriteActivity()));
                        },
                          child: Text("Add New activities "),),],),),
                  SizedBox(height: 20),
                  Expanded(
                    child: SizedBox (height:  200.0,
                      child :Text('Select Activity from list ,'
                          '', textAlign: TextAlign.center ,
                        style: TextStyle(fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(1.0)),),
                    ),),
                  TextButton(onPressed: () {Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> LActivities()));
                  },
                    child: Text("Activities"),),
                  SizedBox(height: 20),
                  //  TODO Consult activities finished of the patient here --------------
                ],),
            ),

          ),),),
    );}
}
//
// class Practicing {
//   Practicing(this.eventName, this.from, this.to, this.background, this.isAllDay);
//   String eventName;
//   DateTime from;
//   DateTime to;
//   Color background;
//   bool isAllDay;
// }
// List<Practicing> _getDataSource() {
//   final List<Practicing> practicing = <Practicing>[];
//   final DateTime today = DateTime.now();
//   final DateTime startTime =
//   DateTime(today.year, today.month, today.day, 9, 0, 0);
//   final DateTime endTime = startTime.add(const Duration(hours:1));
//   practicing.add(Practicing(
//       'Practice Activity', startTime, endTime, const Color(0xFF0F8644), false));
//   return practicing;
// }
// // ----- Creates a practicing data source, which used to set the appointment collection to the calendar----
// class PracticingDataSources extends CalendarDataSource {
//   PracticingDataSources(List<Practicing> getDataSource);
//
//   //PracticingDataSources(getDataSource);
//   // ignore: non_constant_identifier_names
//   PracticingDataSource(List<Practicing> source) {
//   appointments = source;
//   }
//
//   @override
//   DateTime getStartTime(int index) {
//   return _getPracticingData(index).from;
//   }
//
//   @override
//   DateTime getEndTime(int index) {
//   return _getPracticingData(index).to;
//   }
//
//   @override
//   String getSubject(int index) {
//   return _getPracticingData(index).eventName;
//   }
//
//   @override
//   Color getColor(int index) {
//   return _getPracticingData(index).background;
//   }
//
//   @override
//   bool isAllDay(int index) {
//   return _getPracticingData(index).isAllDay;
//   }
//
//   Practicing _getPracticingData(int index) {
//   final dynamic practicing = appointments![index];
//   late final Practicing practicingData;
//   if (practicing is Practicing) {
//   practicingData = practicing;
//   }
//   return practicingData;
//   }
//   }

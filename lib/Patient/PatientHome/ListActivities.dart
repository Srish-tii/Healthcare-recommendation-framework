import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
/// ------------------------ Fetch data from the internet -----------------------------
List<Activity> parseActivities(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Activity>((json) =>Activity.fromJson(json)).toList();}

Future<List<Activity>> fetchActivities(Type client)async {
  final response = await http.get(Uri.parse('https://patient-tracking-34e27-default-rtdb.europe-west1.firebasedatabase.app/activity.json'));
  return compute(parseActivities, response.body);
}
/// ------------------- Activity class -------------------------
class Activity {
  late String name;
  late String category ;
  late String location ;
  Activity({required this.name,
    required this.category,
    required this.location,} );

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      name : json['name'],
      category : json['category'],
      location: json['location'],);}
}
class LActivities extends StatelessWidget {
  final activities = <Activity>[] ;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activities',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Activity list'),
        ),
        body: Center(
          child: Padding (padding: const EdgeInsets.only(top : 15.0),
              child : Column (
                children: <Widget>[
                  FutureBuilder<List<Activity>>(
                    future: fetchActivities(http.Client),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2
                          ),
                          itemCount: activities.length,
                          itemBuilder: (BuildContext context, int index) {
                            return
                              Text(activities[index].name ,semanticsLabel: activities[index].category);
                          },);

                      } else if (snapshot.hasError) {
                        print (snapshot.error);
                      }
                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  ),
                ],)

          ),),),);
  }}
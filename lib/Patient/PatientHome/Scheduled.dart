import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'practtime.dart';

class ScheduledActivities extends StatefulWidget {
  @override
  _ScheduledActivitiesState createState() => _ScheduledActivitiesState();
}

class _ScheduledActivitiesState extends State<ScheduledActivities> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scheduled Activities'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchScheduledActivities(_auth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading activities'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No activities scheduled.'));
          } else {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 24.0,
                  columns: [
                    DataColumn(label: Text('Activity ID')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Location')),
                  ],
                  rows: snapshot.data!.map<DataRow>((activity) {
                    return DataRow(
                      cells: [
                        DataCell(Text(activity['activityId'] ?? '')),
                        DataCell(Text('${activity['selectedDate'] ?? ''}')),
                        DataCell(
                          Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  activity['activityAddress'] ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchScheduledActivities(
      String patientId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('activities')
        .where('patientId', isEqualTo: patientId)
        .get();

    List<Map<String, dynamic>> scheduledActivities = [];
    for (var doc in querySnapshot.docs) {
      DateTime? date = (doc['selectedDate'] as Timestamp?)?.toDate();
      scheduledActivities.add({
        'activityId': doc['activityId'] ?? '', // Handle null activityId
        'selectedDate': date != null
            ? '${date.day}/${date.month}/${date.year}'
            : '', // Handle null date
        'activityAddress':
            doc['activityAddress'] ?? '', // Handle null activityAddress
      });
    }
    return scheduledActivities;
  }
}

void main() {
  runApp(MaterialApp(
    home: ScheduledActivities(),
  ));
}

import 'package:flutter/material.dart';
import 'package:rastreador/Patient/PatientHome/AddAct.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'PatientHome.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class PractTime extends StatefulWidget {
  final LocationData? selectedActivity;

  PractTime({this.selectedActivity});

  @override
  _PractTimeState createState() => _PractTimeState();
}

class _PractTimeState extends State<PractTime> {
  DateTime? _selectedDate;
  FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Create an instance of Firestore

  DateRangePickerController _datePickerController = DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    print(
        'Selected Activity: ID - ${widget.selectedActivity?.id}, Address - ${widget.selectedActivity?.address}');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select Time of Practicing'),
        ),
        body: SfDateRangePicker(
          view: DateRangePickerView.month,
          selectionMode: DateRangePickerSelectionMode.single,
          showActionButtons: true,
          controller: _datePickerController,
          onSubmit: (Object? val) {
            if (val is DateTime) {
              // Check if selected date is in the past
              if (val.isBefore(DateTime.now())) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Invalid Date'),
                      content: Text('Please select a future date.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              } else {
                setState(() {
                  _selectedDate = val;
                });
                _showConfirmationDialog();
              }
            }
          },
          onCancel: () {
            _datePickerController.selectedDate = null;
          },
        ),
      ),
    );
  }

  void _showConfirmationDialog() async {
    List<DateTime> scheduledDates =
        await _fetchScheduledDates(_auth.currentUser!.uid);

    if (scheduledDates.contains(_selectedDate)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'This date already has a scheduled activity. Please select again.'),
          duration: Duration(seconds: 5),
        ),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Scheduling Activity'),
          content: Text(
            'Scheduling activity ID ${widget.selectedActivity?.id} at ${widget.selectedActivity?.address} on ${_selectedDate?.day}/${_selectedDate?.month}/${_selectedDate?.year}',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                User? user = _auth.currentUser;
                if (user != null) {
                  String patientId = user.uid;
                  await _uploadToFirestore(patientId);
                } else {
                  print('No user is currently logged in.');
                }
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PatientProfile()),
                );
              },
              child: Text('Ok and Exit'),
            ),
            TextButton(
              onPressed: () async {
                User? user = _auth.currentUser;
                if (user != null) {
                  String patientId = user.uid;
                  await _uploadToFirestore(patientId);
                } else {
                  print('No user is currently logged in.');
                }
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WriteActivity()),
                );
              },
              child: Text('Schedule another activity'),
            ),
            TextButton(
              onPressed: () async {
                User? user = _auth.currentUser;
                if (user != null) {
                  String patientId = user.uid;
                  await _uploadToFirestore(patientId);
                } else {
                  print('No user is currently logged in.');
                }
                Navigator.pop(context);
              },
              child: Text('Schedule same activity again'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _uploadToFirestore(String patientId) async {
    try {
      await _firestore.collection('activities').add({
        'activityId': widget.selectedActivity?.id,
        'activityAddress': widget.selectedActivity?.address,
        'selectedDate': _selectedDate,
        'patientId': patientId,
      });
      print('Data uploaded to Firestore successfully');
    } catch (e) {
      print('Error uploading data to Firestore: $e');
    }
  }

  Future<List<DateTime>> _fetchScheduledDates(String patientId) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('activities')
        .where('patientId', isEqualTo: patientId)
        .get();

    List<DateTime> scheduledDates = [];
    for (var doc in querySnapshot.docs) {
      DateTime? date = (doc['selectedDate'] as Timestamp?)?.toDate();
      if (date != null) {
        scheduledDates.add(DateTime(date.year, date.month, date.day));
      }
    }
    return scheduledDates;
  }
}

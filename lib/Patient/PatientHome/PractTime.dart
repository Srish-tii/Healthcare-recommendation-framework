// import 'package:flutter/material.dart';
// import 'package:rastreador/Patient/PatientHome/AddAct.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// class PractTime extends StatefulWidget {
//   final LocationData? selectedActivity;

//   PractTime({this.selectedActivity});

//   @override
//   _PractTimeState createState() => _PractTimeState();
// }

// class _PractTimeState extends State<PractTime> {
//   DateTime? _selectedDate;

//   DateRangePickerController _datePickerController = DateRangePickerController();

//   @override
//   Widget build(BuildContext context) {
//     print(
//         'Selected Activity: ID - ${widget.selectedActivity?.id}, Address - ${widget.selectedActivity?.address}');
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Select Time of Practicing'),
//         ),
//         body: SfDateRangePicker(
//           view: DateRangePickerView.month,
//           selectionMode:
//               DateRangePickerSelectionMode.single, // Change selection mode
//           showActionButtons: true,
//           controller: _datePickerController,
//           onSubmit: (Object? val) {
//             if (val is DateTime) {
//               setState(() {
//                 _selectedDate = val;
//               });
//               _showConfirmationDialog();
//             }
//           },
//           onCancel: () {
//             _datePickerController.selectedDate = null;
//           },
//         ),
//       ),
//     );
//   }

//   void _showConfirmationDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Scheduling Activity'),
//           content: Text(
//             'Scheduling activity ID ${widget.selectedActivity?.id} at ${widget.selectedActivity?.address} on ${_selectedDate?.day}/${_selectedDate?.month}/${_selectedDate?.year}',
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Close the pop-up
//                 Navigator.pop(context); // Go back to the previous screen
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:rastreador/Patient/PatientHome/AddAct.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import the Firestore package
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
              setState(() {
                _selectedDate = val;
              });
              _showConfirmationDialog();
            }
          },
          onCancel: () {
            _datePickerController.selectedDate = null;
          },
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
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
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

//   Future<void> _uploadToFirestore() async {
//     try {
//       await _firestore.collection('activities').add({
//         'activityId': widget.selectedActivity?.id,
//         'activityAddress': widget.selectedActivity?.address,
//         'selectedDate': _selectedDate,
//       });
//       print('Data uploaded to Firestore successfully');
//     } catch (e) {
//       print('Error uploading data to Firestore: $e');
//     }
//   }
// }
  Future<void> _uploadToFirestore(String patientId) async {
    try {
      await _firestore.collection('activities').add({
        'activityId': widget.selectedActivity?.id,
        'activityAddress': widget.selectedActivity?.address,
        'selectedDate': _selectedDate,
        'patientId': patientId, // Add the patient ID
      });
      print('Data uploaded to Firestore successfully');
    } catch (e) {
      print('Error uploading data to Firestore: $e');
    }
  }
}

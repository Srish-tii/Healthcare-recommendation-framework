import 'package:flutter/material.dart';
import 'package:rastreador/Patient/PatientHome/AddAct.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'ListActivities.dart';

class PractTime extends StatefulWidget {
  final LocationData? selectedActivity;

  PractTime({this.selectedActivity});

  @override
  _PractTimeState createState() => _PractTimeState();
}

class _PractTimeState extends State<PractTime> {
  DateTime? _selectedDate;

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
          selectionMode:
              DateRangePickerSelectionMode.single, // Change selection mode
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
              onPressed: () {
                Navigator.pop(context); // Close the pop-up
                Navigator.pop(context); // Go back to the previous screen
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

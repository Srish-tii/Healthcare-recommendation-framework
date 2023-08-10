import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rastreador/Patient/PatientHome/AddAct.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'ListActivities.dart';

class PractTime extends StatelessWidget {
  final LocationData? selectedActivity;

  PractTime({this.selectedActivity});

  DateRangePickerController _datePickerController = DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    print(
        'Selected Activity: ID - ${selectedActivity?.id}, Address - ${selectedActivity?.address}');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select Time of Practicing'),
        ),
        body: SfDateRangePicker(
          view: DateRangePickerView.month,
          selectionMode: DateRangePickerSelectionMode.multiRange,
          showActionButtons: true,
          controller: _datePickerController,
          onSubmit: (Object? val) {
            print(val);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LActivities()),
            );
          },
          onCancel: () {
            _datePickerController.selectedRanges = null;
          },
        ),
      ),
    );
  }
}

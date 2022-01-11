import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PractTime extends StatelessWidget {
  DateRangePickerController _datePickerController = DateRangePickerController();
  @override
  Widget build(BuildContext context) {
    return SafeArea( child :Scaffold(
      body:  SfDateRangePicker(view: DateRangePickerView.month,
        selectionMode : DateRangePickerSelectionMode.multiRange ,
        showActionButtons: true,
        controller: _datePickerController,
        onSubmit: (Object val){
          print(val);
        },
        onCancel: (){
          _datePickerController.selectedRanges = null ;
        },),)); }}
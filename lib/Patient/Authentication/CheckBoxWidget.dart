import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ------------------------ Check box widget to select Gender --------------------------
class Gender extends StatefulWidget {
  @override
  State <Gender> createState() => _checkboxwidget();}
class _checkboxwidget extends State<Gender> {
  bool isChecked = false;
  bool valuefirst = false;
  bool valuesecond = false;
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('Flutter Checkbox Example'),),
          body: Container(
              child: Column(
                children: <Widget>[
                CheckboxListTile(
                  secondary: Icon(Icons.female),
                  title : Text('Female') ,
                  controlAffinity: ListTileControlAffinity.platform,
                  value: valuefirst,
                  onChanged: (value) => true ,
                  activeColor: Colors.greenAccent,
                  checkColor: Colors.black38,
                ),
                CheckboxListTile(
                  secondary: Icon(Icons.male),
                  title : Text('Male') ,
                  controlAffinity: ListTileControlAffinity.platform,
                  value: valuesecond,
                  onChanged: (value) => true ,
                  activeColor: Colors.greenAccent,
                  checkColor: Colors.black38,
                ),],),
          ),
        ),
      );
    }
  }

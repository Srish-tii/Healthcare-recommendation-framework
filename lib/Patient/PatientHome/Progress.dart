import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
class PatientProgress extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child : Text(''),),],),),),),),
    );
  }

}
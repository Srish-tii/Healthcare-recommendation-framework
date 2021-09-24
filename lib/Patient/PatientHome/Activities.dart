import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class SelectActivity extends StatelessWidget{
  final _actname = TextEditingController();
  final _actype = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (title: Text('Patient Subscription Page')),
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
                  child : TextFormField(
                controller: _actname,
                validator: (value){
                  if (value!.isEmpty){
                    return 'Give activity name';
                  }
                  return null ;
                },
                  decoration: InputDecoration(
                    labelText: 'Activity name',
                    hintText: 'Activity name',
                    border : OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    prefixIcon: Icon(Icons.accessibility_new),
                  ),),),
                    SizedBox(height : 10),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child : TextFormField(
                        controller: _actype,
                        validator: (value){
                          if (value!.isEmpty){
                            return 'Add the activity category';
                          }
                          return null ;
                        },
                        decoration: InputDecoration(
                          labelText: 'Activity category',
                          hintText: 'Activity category',
                          border : OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          prefixIcon: Icon(Icons.accessibility_new),
                        ),),),
    ],),),),),),
    );
}
}

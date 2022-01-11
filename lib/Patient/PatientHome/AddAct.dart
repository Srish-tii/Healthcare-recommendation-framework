import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import 'package:http/http.dart' as http ;

/// --------------------------- Add new Activity page ------------------------------
class WriteActivity extends StatefulWidget{
  @override
  _AddActivity createState() => _AddActivity();
}
class _AddActivity extends State<WriteActivity>{
  //final database = FirebaseDatabase.instance.reference() ;
  final _actname = TextEditingController();
  final _actype = TextEditingController();
  final _actlocation = TextEditingController();

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      style: TextButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          primary: Colors.white,
          textStyle: const TextStyle(fontSize: 20)),
      child: Text("OK"),
      onPressed: (){ Navigator.push(context,
          MaterialPageRoute(builder: (context)=> MyApp()));},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Exit"),
      content: Text("Do you want to exit !"),
      actions: [
        okButton,
      ],
      elevation: 24.0,
      backgroundColor: Colors.blueGrey[200],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) => alert );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (title: Text('Add Activities')),
      body:Container(
        child: SingleChildScrollView(
          child :Padding (
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child : Column (
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                        prefixIcon: Icon(Icons.category_outlined),
                      ),),),
                  SizedBox(height : 10),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child : TextFormField(
                      controller: _actlocation,
                      validator: (value){
                        if (value!.isEmpty){
                          return 'Add the activity Location';
                        }
                        return null ;
                      },
                      decoration: InputDecoration(
                        labelText: 'Activity location',
                        hintText: 'Location of the activity',
                        border : OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: Icon(Icons.location_on),
                      ),),),
                  SizedBox(height : 50),
                  MaterialButton(onPressed: () async{
                    List<String> data = [];
                    String actname = _actname.text ;
                    String actCat = _actype.text ;
                    String actlocation = _actlocation.text ;
                    data.add(actname);
                    data.add(actCat);
                    data.add(actlocation);
                    http.Response res = await createCoach(data) ;
                    if(res.statusCode == 200) {
                      AlertDialog show = AlertDialog(
                        title: Text("Activity created successfully "),
                        content: Text("Save and continue !"),
                        actions: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                onPressed:()=> {//Navigator.push(context, MaterialPageRoute(builder: (context)=> Activities())),
                                }, child: Text("Ok"),
                              ),
                              SizedBox(width: 10,),
                              TextButton(
                                onPressed:() => {Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=> MyApp())),},
                                child: Text("exit"),),
                            ],  ),  ] ,
                        elevation: 24.0,
                        backgroundColor: Colors.blueGrey[200],
                      );
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => show );
                    }},
                      height: 50,
                      minWidth: double.infinity,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white ,
                      shape :RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text("Save" ,
                        style: TextStyle(fontSize: 15, fontWeight :FontWeight.bold),)),

                ],),),),),),
    );
  }
}

///  ------------------------- Save data ---------------------------
Future<http.Response> createCoach(List<String> data) async{
  return http.post(Uri.parse('https://patient-tracking-34e27-default-rtdb.europe-west1.firebasedatabase.app/activity.json'),
    headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
    body: jsonEncode(<String, String>
    {
      "name" : data[0],
      "id_category" : data[1],
      "location" : data[2],
      "id_patient" : " ",
    }),
  );
}
/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
class WriteActivity extends StatefulWidget{
  @override
  SelectActivity createState() => SelectActivity();
}
class SelectActivity extends State<WriteActivity>{
  //final database = FirebaseDatabase.instance.reference() ;
  final _actname = TextEditingController();
  final _actype = TextEditingController();
  final _actlocation = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final activitiyRef = database.child('/activity');
    return Scaffold(
      appBar: AppBar (title: Text('Activities')),
      body:SafeArea(
        child: SingleChildScrollView(
          child :Padding (
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child : Column (
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ElevatedButton(onPressed: (){
                    */
/* activitiyRef.set({'id_acivity' : '0001',
                      'name' : 'walking' ,
                        'location' : 'Walking street'
                      });*//*

                  }, child: Text('set activity')),
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
                  SizedBox(height : 10),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child : TextFormField(
                      controller: _actlocation,
                      validator: (value){
                        if (value!.isEmpty){
                          return 'Give activity name';
                        }
                        return null ;
                      },
                      decoration: InputDecoration(
                        labelText: 'Activity practicing place',
                        hintText: 'Activity location',
                        border : OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: Icon(Icons.location_on_outlined),
                      ),),),
                ],),),),),),
    );
  }
}
*/

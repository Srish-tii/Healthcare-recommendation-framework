import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rastreador/Patient/Authentication/Register.dart';
import 'package:rastreador/Patient/PatientHome/ActivitiesFinished.dart';
import 'package:rastreador/Patient/PatientHome/Feedback.dart';
import 'package:rastreador/Patient/PatientHome/Progress.dart';
import '../../main.dart';
import 'package:http/http.dart' as http;
// --------------------- Patient Profile Page  ----------------------------
class PatientProfile extends StatefulWidget {
  @override
  Patient createState() {
    return Patient();
  }
}
class Patient extends State<PatientProfile>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patient Profile'),),
//---------- List of navigation pages in patient profile page--
       drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.green[200],
              ),
              child: Text('Home '),

            ),
            ListTile(
              title: Text('Patient Profile'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PatientProfile()),);
              },
            ),
            ListTile(
              title: Text('Activities Finished'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Activities()),);
              },
            ),
            ListTile(
              title: Text('Consult Progress'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PatientProgress()),);
              },
            ),
            ListTile(
              title: Text('Give Feedback'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PatientFeedback()),);
              },
            ),
          ],
        ),
      ),
// --------------------------------- The body of patient page --------------------------------------
      body : SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all((20.0)),
            child : Form(
              child : Column (
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton( icon: Icon(Icons.arrow_back_ios,
                    color:Theme.of(context).primaryColor ,),
                      onPressed: (){ Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> MyApp()));}
                  ),
                  SizedBox(height : 10),
                  Text ('Welcome, (patient data here),',style: TextStyle(fontStyle: FontStyle.italic),),
                  SizedBox(height: 10),
                  Container (
                    child :Row(
                      mainAxisAlignment : MainAxisAlignment.center ,
                      children : [
                        SizedBox(width: 5),
                        Expanded(child: Padding (
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                          child :  Image(
                              image: AssetImage('assets/progress.png'),width:110,height:90),),),
                        SizedBox(height: 10,),
                        TextButton(onPressed: () {Navigator.push(context,
                            MaterialPageRoute(builder: (context)=> PatientProgress()));
                        },
                          child: Text("Consult progress"),
                        ),
                      ],),),
                  Container (
                    child :Row(
                      mainAxisAlignment : MainAxisAlignment.center ,
                      children : [
                        SizedBox(width: 5),
                        Expanded(child: Padding (
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
                          child :  Image(
                              image: AssetImage('assets/Actfinished.png'),width:110,height:90),),),
                        SizedBox(height: 10,),
                        TextButton(onPressed: () {Navigator.push(context,
                            MaterialPageRoute(builder: (context)=> Activities()));
                        },
                          child: Text("Select Activity"),
                        ),
                      ],),),
                  SizedBox(height: 30),
                 Row(
                   mainAxisAlignment : MainAxisAlignment.center ,
                   children :[
                   Text('Add new disease :'),
                   SizedBox(width: 5),
                   TextButton(onPressed: () {Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> Activities()));
                      },
                      child: Text ('Disease'),
                   ),],),
                  SizedBox(width:30),
                  Row (
                    mainAxisAlignment : MainAxisAlignment.center ,
                    children :[
                      Text ('Give your Feedback :'),
                  TextButton(onPressed: () {Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> PatientFeedback()));
                  },
                    child: Text("Feedback"),
                  ),],),
                      SizedBox(width: 30,),
                     Row (
                         mainAxisAlignment : MainAxisAlignment.center ,
                         children :[
                      Text ('Update your personal information '),
                       TextButton(onPressed: () {Navigator.push(context,
                               MaterialPageRoute(builder: (context)=> Register()));
                           },
                         child: Text ('Update information'),
                         ),],),
         ], ),
        ),
      ),
    ),),);
  }}

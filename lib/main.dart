import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rastreador/Coach/CoachRegistration.dart';
import 'package:rastreador/Caregiver/Authentication/DoctorRegistration.dart';
import 'package:rastreador/Caregiver/Authentication/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Coach/AddCoach.dart';
import 'Coach/Login.dart';
import 'Patient/Authentication/AddPatient.dart';
import 'Patient/Authentication/Login.dart';
import 'Patient/Authentication/Register.dart';
import 'Patient/Information.dart';
import 'package:location/location.dart';
import 'UserDescription.dart';
import 'UserAccount.dart';

Future<void> main() async {
  /// *************** Ensure Firebase Initialization ***************
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// **************** Enable  Users Location  ****************
  Location location = new Location();
  location.enableBackgroundMode(enable: true);
  runApp(MaterialApp(
    title: 'Patient Tracking App',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Patient Tracking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient Tracker"),
      ),
      body: Container(
        //constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: const Color(0xff7c94b6),
          image: DecorationImage(
              image: AssetImage("assets/back3.jpg"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  UserDescription(
                    content:
                        "Get start with our application, schedule your daily activities time and consult your caregiver advices.",
                    imageString: 'assets/trackingpt.png',
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddPatient()));
                          },
                          child: Text("Create New Account",
                              style: TextStyle(color: Colors.white)),
                        ),
                        Text(' Or'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: Text("Login ",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  // UserAccount(NewUser: AddPatient, Login: Login),
                  SizedBox(height: 20),
                  UserDescription(
                    content:
                        'Get start with our application to consult your patients health and give your prescription .',
                    imageString: 'assets/caregiver.png',
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegistrationDoctor()));
                          },
                          child: Text("Create Doctor Account",
                              style: TextStyle(color: Colors.white)),
                        ),
                        Text("Or"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogIn()));
                          },
                          child: Text("Login",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  UserDescription(
                    content:
                        'Get start with our application, consult your patients activities progress and give recommendation.',
                    imageString: 'assets/healthcare.png',
                  ),
                  SizedBox(height: 15),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddCoach()));
                          },
                          child: Text("Create Coach Account",
                              style: TextStyle(color: Colors.white)),
                        ),
                        Text("Or"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CLogin()));
                          },
                          child: Text("Login",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("To Know about us :"),
                      SizedBox(width: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MoreInfo()));
                        },
                        child: Text("More Information"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => exit(0),
        tooltip: 'Close app',
        label: const Text('Exit'),
        icon: Icon(Icons.home),
        backgroundColor: Colors.lightGreen,
      ),
    );
  }
}

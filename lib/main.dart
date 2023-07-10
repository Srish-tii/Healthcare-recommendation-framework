import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'Patient/Information.dart';
import 'package:location/location.dart';
import 'CommonWidgets/UserDescription.dart';
import 'CommonWidgets/UserAccount.dart';
import 'package:geolocator/geolocator.dart';

Future<void> main() async {
  /// *************** Ensure Firebase Initialization ***************
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        decoration: BoxDecoration(
          color: const Color(0xff7c94b6),
          image: DecorationImage(
              image: AssetImage("assets/back3.jpg"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 100.0, bottom: 60.0, right: 50, left: 50),
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
                  UserAccount(user: 'patient', text: 'Create Patient Account'),
                  SizedBox(height: 20),
                  UserDescription(
                    content:
                        'Get start with our application to consult your patients health and give your prescription .',
                    imageString: 'assets/caregiver.png',
                  ),
                  SizedBox(height: 10),
                  UserAccount(user: 'doctor', text: 'Create Doctor Account'),
                  SizedBox(height: 20),
                  UserDescription(
                    content:
                        'Get start with our application, consult your patients activities progress and give recommendation.',
                    imageString: 'assets/healthcare.png',
                  ),
                  SizedBox(height: 10),
                  UserAccount(user: 'coach', text: 'Create Coach Account'),
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

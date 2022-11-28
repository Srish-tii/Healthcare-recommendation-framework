import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rastreador/Doctor/CaregiverHome/CaregiverHome.dart';

/// -----------------  loading patient data from database -------------------
class Patient {
  String firstName;
  String lastName;
  Patient({
    required this.firstName,
    required this.lastName,
  });
  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      firstName: json['first name'],
      lastName: json['last name'],
    );
  }
}

List<Patient> parsePatient(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Patient>((json) => Patient.fromJson(json)).tolist();
}

Future<List<Patient>> fetchPatient() async {
  final response = await http.get(Uri.parse(
      ('https://patient-tracking-34e27-default-rtdb.europe-west1.firebasedatabase.app/patient.json')));
  if (response.statusCode == 200) {
    return parsePatient(response.body);
  } else {
    throw Exception('Failed to load patient');
  }
}

/// ********************** Doctor Prescription class ****************************
class DoctPrescription extends StatefulWidget {
  @override
  _Prescription createState() => _Prescription();
}

class _Prescription extends State<DoctPrescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Prescription'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter patient name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your prescription',
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Caregiverprofile()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

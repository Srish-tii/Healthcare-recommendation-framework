
import 'dart:convert';
import 'dart:js';
import 'dart:async';
import 'package:http/http.dart' as http ;
import 'package:flutter/material.dart';

/// -----------------  loading patient data from database -------------------
class Patient {
  String Firstname ;
  String Lastname ;
  Patient ({
    required this.Firstname,
    required this.Lastname,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      Firstname : json['first name'],
      Lastname: json['last name'],
    );
  }
}
List <Patient> parsePatient (String responseBody){
  final parsed = json.decode(responseBody).cast<Map<String ,dynamic>>();
  return parsed.map<Patient>((json)=> Patient.fromJson(json)).tolist();
}
Future<List<Patient>> fetchPatient() async {
  final response = await http.get(Uri.parse(('https://patient-tracking-34e27-default-rtdb.europe-west1.firebasedatabase.app/patient.json')));
  if (response.statusCode == 200) {
    return parsePatient(response.body) ;
  } else {
    throw Exception('Failed to load patient');
  }
}
/// ********************** Doctor Prescription class ****************************
class _Prescription extends StatefulWidget {
  @override
  DoctPrescription  createState() => DoctPrescription();
  }

class DoctPrescription extends State<_Prescription> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title:  Text ('Doctor Prescription'),),
      body: Container(
        child: Column(
          children: [

          ],
        ),
      ),
    );

  }

}

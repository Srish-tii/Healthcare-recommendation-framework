import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Patient>> fetchPatients(http.Client client) async {
  final response = await client.get(Uri.parse(
      'https://patient-tracking-34e27-default-rtdb.europe-west1.firebasedatabase.app/patient.json'));
  // Use the compute function to run parsePateints in a separate isolate.
  return compute(parsePatients, response.body);
}

// A function that converts a response body into a List<Patient>.
List<Patient> parsePatients(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Patient>((json) => Patient.fromJson(json)).toList();
}

class Patient {
  final String firstName;
/*  final String last_name;
  final String address;*/

  const Patient({
    required this.firstName,
    /*  required this.last_name,
    required this.address,*/
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      firstName: json['first name'] as String,
      /* last_name: json['last name'] as String,
      address: json['address'] as String,*/
    );
  }
}

class PatientList extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient List"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<Patient>>(
          future: fetchPatients(http.Client()),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('An error has occurred!'),
              );
            } else if (snapshot.hasData) {
              return PatientsList(patients: snapshot.data!);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class PatientsList extends StatelessWidget {
  const PatientsList({Key? key, required this.patients}) : super(key: key);

  final List<Patient> patients;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: patients.length,
      itemBuilder: (context, index) {
        return Text(patients[index].firstName);
      },
    );
  }
}
/*

class PatientList extends StatefulWidget {
  @override
  PatientNameState createState() => PatientNameState();
}
class PatientNameState extends State<PatientList> {
  final  _patientnames = <PatientNames> [];
  final _savedlist = Set<PatientNames>();
  Widget _buildList(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item){
        if(item.isOdd) return Divider();
        final index = item ~/2 ;
        if (index >= _patientnames.length){
          _patientnames.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_patientnames[index]);},);}
  Widget _buildRow(PatientNames pair){
    final alreadySaved = _savedlist.contains(pair);
    return ListTile(
        title: Text(pair.asPascalCase, style: TextStyle
          (fontSize: 18.0)),
        trailing: Icon(alreadySaved ? Icons.check_circle: Icons.check,
            color: alreadySaved ? Colors.greenAccent: null),
        onTap: (){
          setState(() {
            if(alreadySaved){
              _savedlist.remove(pair);
            } else {
              _savedlist.add(pair);}});});}
  void _pushSaved(){
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (BuildContext context){
              final Iterable<ListTile>tiles = _savedlist.map((PatientNames pair){
                return ListTile(
                    title: Text(pair.asPascalCase,style: TextStyle(fontSize: 16.0)));});
              final List<Widget> divided = ListTile.divideTiles(
                  context: context,
                  tiles: tiles
              ).toList();
              return Scaffold(
                  appBar: AppBar(title: Text('Selected Names')),
                  body: ListView(children: divided));}));}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(('Patient List')),
            actions: <Widget>[
              IconButton(
                  icon:Icon(Icons.list),
                  onPressed: _pushSaved)
            ]
        ),
        body: _buildList());
  }
  }
*/

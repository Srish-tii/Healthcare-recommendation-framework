import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// ------------------------ Fetch data from the DB -----------------------------

List<Disease> parseDiseases(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Disease>((json) => Disease.fromJson(json)).toList();
}

Future<List<Disease>> fetchDiseases(Type client) async {
  final response = await http.get(Uri.parse(
      'https://rastreador-6719e-default-rtdb.europe-west1.firebasedatabase.app/disease.json'));
  return compute(parseDiseases, response.body);
}

/// ------------------- Disease class -------------------------
class Disease {
  final String name;
  Disease({required this.name});

  factory Disease.fromJson(Map<String, dynamic> json) {
    return Disease(name: json['name'] as String);
  }
}

/// ---------------------- Disease list widget -----------------------
class ListDisease extends StatefulWidget {
  @override
  GetDisease createState() => GetDisease();
}

class GetDisease extends State<ListDisease> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Diseases List'),
        ),
        body: FutureBuilder<List<Disease>>(
          future: fetchDiseases(http.Client),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? diseaselist(diseases: snapshot.data!)
                : Center(child: CircularProgressIndicator());
          },
        ));
  }
}

class diseaselist extends StatelessWidget {
  late final List<Disease> diseases;
  diseaselist({required this.diseases});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: diseases.length,
        itemBuilder: (context, index) {
          return Text(diseases[index].name);
        });
  }
}

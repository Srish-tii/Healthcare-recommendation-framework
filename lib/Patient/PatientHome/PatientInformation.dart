import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class GetPatientName extends StatelessWidget {
  final String documentId;

  GetPatientName(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference patients = FirebaseFirestore.instance.collection('Patient');

    return FutureBuilder<DocumentSnapshot>(
      future: patients.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Text("Full Name: ${data['first_name']} ${data['last_name']}");
        }

        return Text("loading");
      },
    );
  }
}
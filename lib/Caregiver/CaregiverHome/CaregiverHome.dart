import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rastreador/Caregiver/Screens/Prescription.dart';
import 'package:rastreador/main.dart';
import 'PatientList.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Caregiverprofile extends StatefulWidget {
  _CaregiverProfile createState() => _CaregiverProfile();
}
class _CaregiverProfile extends State<Caregiverprofile>{
  final _pwdController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();
  showAlertDialog(BuildContext context) {
    // set up the button
    // ignore: deprecated_member_use
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () { Navigator.push(context,
          MaterialPageRoute(builder: (context)=> MyApp()));},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Consult Patients List"),
      content: Text("Patients List"),
      actions: [
        okButton,
      ],);
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },);}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Caregiver profile'),
        actions: <Widget>[
          Builder(builder: (BuildContext context) {
            // ignore: deprecated_member_use
            return FlatButton(
              child: const Text('Sign out'),
              textColor: Theme
                  .of(context)
                  .buttonColor,
              onPressed: () async {
                final User? user = _auth.currentUser ;
                if (user == null) {
                  // ignore: deprecated_member_use
                  Scaffold.of(context).showSnackBar(const SnackBar(
                    content: Text('No one has signed in.'),
                  ));
                  return;
                }
                await _auth.signOut();
                final String uid = user.uid;
                // ignore: deprecated_member_use
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(uid + ' has successfully signed out.'),
                ));
              },);}),],
      ),
      body: Builder(builder :(BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Form(
            key: _fromKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container (
                  height: 325,
                  width: double.infinity,
                  decoration: BoxDecoration(image: DecorationImage(image:AssetImage('assets/vdoc3.jpg'),
                      fit: BoxFit.fill)),
                ),
                Text('Caregiver Profile ', style: Theme.of(context).textTheme.headline6,),
                RichText(
                  text: TextSpan(
                    text: 'Caregiver Name ',
                    children: const <TextSpan>[
                      TextSpan(text: 'Doctor/ Coach', style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey),),],),),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child:ElevatedButton(
                    child: Text('Patient Lists'),
                    onPressed: () {Navigator.push(context,
                        MaterialPageRoute(
                        builder: (context) => PatientList()));},),),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child:ElevatedButton(
                    child: Text('Add New patient'),
                    onPressed: () {showAlertDialog(context);},),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child:ElevatedButton(
                    child: Text('Give Prescription'),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DoctPrescription()));},),),],),),);},),
      );
  }}



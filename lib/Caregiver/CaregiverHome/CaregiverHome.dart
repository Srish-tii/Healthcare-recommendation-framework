import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rastreador/main.dart';
class _CaregiverProfile extends StatelessWidget {
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
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Form(
            key: _fromKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                    onPressed: () {
                      showAlertDialog(context);},),),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child:ElevatedButton(
                    child: Text('Add New patient'),
                    onPressed: () {
                      showAlertDialog(context);},),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child:ElevatedButton(
                    child: Text('Give Prescription'),
                    onPressed: () {
                      showAlertDialog(context);},),),],),),),),
      floatingActionButton: FloatingActionButton.extended(
        onPressed :() {
          if (_fromKey.currentState!.validate()){
            Text('Welcome !');}},
        label : const Text('Exit'),
        icon: Icon(Icons.home),
        backgroundColor: Colors.lightGreen,),);}}



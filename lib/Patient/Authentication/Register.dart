import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rastreador/Patient/Authentication/Login.dart';
import '../../main.dart';
import 'package:http/http.dart' as http;

// ---------------------- Subscription Page ------------------------------
class Register extends StatelessWidget{
  final _fromKey = GlobalKey<FormState>();
  final _pwdController = TextEditingController();
  final _confpwdController = TextEditingController();
  final _emailController = TextEditingController();
  late bool  valuefirst = true ;
  late bool valuesecond = false ;
 // Gender? _sexe = Gender.female ;
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          primary: Colors.white,
          textStyle: const TextStyle(fontSize: 20)),
      child: Text("OK"),
      onPressed: (){ Navigator.push(context,
        MaterialPageRoute(builder: (context)=> MyApp()));},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Exit"),
      content: Text("Do you want to exit !"),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (title: Text('Patient Subscription Page')),
      body:SafeArea(
        child: SingleChildScrollView(
          child :Padding (
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _fromKey,
              child : Column (
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton( icon:Icon(Icons.home , color:Theme.of(context).primaryColor),
                    onPressed: (){Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> MyApp())); },
                  ),
                  SizedBox(height : 10),
                  TextFormField(
                    validator: (value){
                      if (value!.isEmpty){
                        return 'Patient first name cannot be empty';
                      }
                      return null ;
                    },
                    decoration: InputDecoration(
                      labelText: 'FirstName',
                      hintText: 'Patient first name',
                      border : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      prefixIcon: Icon(Icons.person),
                    ),),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child :TextFormField(
                      validator: (value){
                        if (value!.isEmpty){
                          return 'User last name cannot be empty';
                        }
                        return null ;
                      },
                      decoration: InputDecoration(
                        labelText: 'LastName',
                        hintText: 'Patient Last name',
                        border : OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child :TextFormField(
                      validator: (value){
                        if (value!.isEmpty){
                          return 'User Address cannot be empty';
                        }
                        return null ;
                      },
                      decoration: InputDecoration(
                        labelText: 'Address',
                        hintText: 'Address',
                        border : OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: Icon(Icons.home_work_outlined),
                      ),),),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child :TextFormField(
                      validator: (value){
                        if (value!.isEmpty){
                          return 'User phone number cannot be empty';
                        }else if (value.length < 8 ){
                          return 'Phone number must contains 8 Numbers !';
                        }else if(value.length > 8){
                          return 'Phone number must contains only 8 Numbers !';
                        }
                        return null ;
                      },
                      decoration: InputDecoration(
                        labelText: 'Phone ',
                        hintText: '+216  ',
                        border : OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: Icon(Icons.phone_android),),),), // n// new Divider(height: 5.0, color: Colors.bl//------------- Select gender of user (radio) ---------------
                 Padding(
                    padding: new EdgeInsets.all(3.0),),
                  new Text(
                    'Gender :',
                    style: new TextStyle(
                        fontSize: 15.0, fontWeight: FontWeight.bold),),
                  Column (
                    children: [
                      CheckboxListTile(
                        secondary: const Icon(Icons.female),
                          title : const Text('Female') ,
                          value: this.valuefirst,
                          onChanged: (bool? value){
                           this.valuefirst = true ;
                          }),

                      CheckboxListTile(
                          secondary: const Icon(Icons.male),
                          title : const Text('Male') ,
                          value: this.valuesecond,
                          onChanged: (bool? value){
                            this.valuesecond = false ;
                          }),],),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child :TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter your Email';
                        }
                        return null ;
                      },
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        hintText: 'E-mail',
                        border : OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: Icon(Icons.email),
                      ),),),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child :TextFormField(
                      obscureText: true,
                      controller: _pwdController,
                      validator: (value){
                        if (value!.isEmpty){
                          return 'Password cannot be empty !';
                        }else if (value.length < 6){
                          return 'Password must be at least 6 characters long !';
                        }
                        return null ;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Password',
                        border : OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: Icon(Icons.lock_outline),
                      ),),),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child :TextFormField(
                      obscureText: true,
                      controller: _confpwdController,
                      validator: (value){
                        if (value != _pwdController.value.text){
                          return 'password do not match !';}
                        return null ;
                      },
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Confirm Password',
                        border : OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),),
                  SizedBox(height: 10),
                  MaterialButton(
                      onPressed: () async {
                      //  if(_fromKey.currentState!.validate()){
                          // ignore: unnecessary_statements
                          List<String> data = [];
                          String pass = _pwdController.text;
                          String email = _emailController.text;
                          data.add(pass);
                          data.add( email);
                          http.Response res = await createPatient(data) ;
                          if(res.statusCode == 200) {
                            // todo re-orientation vers l'espace patient
                          }
                           else {
                             // afficher un message d'erreur avec res.body
                          }
                          print(res.body);
                      //  }
                      },
                      height: 50,
                      minWidth: double.infinity,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white ,
                      shape :RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text("Submit" ,
                        style: TextStyle(fontSize: 15, fontWeight :FontWeight.bold),
                      )
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    label: Text('Exit'),
                    icon: Icon(Icons.exit_to_app),
                    style : ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),
                    ),
                    onPressed: () {
                      showAlertDialog(context);},
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment : MainAxisAlignment.center ,
                    children : [
                      Text("Already have an account ?"),
                      SizedBox(width: 20),
                      TextButton(onPressed: () {Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> Login()));
                      },
                        child: Text("Login"),
                      ),
                    ], ),
                ], ),
              /*ElevatedButton(
                child: Text('Submit'),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
              ),*/

            ),

          ),),
      ),

    );

  }
}
// --------------------- Sending Data To server -------------------
Future<http.Response> createPatient(List<String> data) {
  print("during");

  return http.post(
    Uri.parse('https://patient-tracking-34e27-default-rtdb.europe-west1.firebasedatabase.app/patient.json'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>
    {
      "pass" : data[0],
      "email" : data[1],
      "age" : " ",
      "first name" : " ",
      "gender" : " ",
      "id_activity" : " ",
      "id_caregiver" : " ",
      "id_disease" : " ",
      "id_location" : " ",
      "id_patient" : " ",
      "last name" : " ",
      "phone" : " "
    }),
  );
}

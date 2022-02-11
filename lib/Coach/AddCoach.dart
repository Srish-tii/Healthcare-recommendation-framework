import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rastreador/Caregiver/Authentication/Login.dart';

import '../main.dart';

class AddCoach extends StatelessWidget {
  final _fromKey = GlobalKey<FormState>();
  final _pwdController = TextEditingController();
  final _confpwdController = TextEditingController();
  final _fname = TextEditingController();
  final _lname = TextEditingController();
  final _email = TextEditingController();
  final _address = TextEditingController();
  final _phone = TextEditingController();

  // Create a CollectionReference called coaches that references the firestore collection
  CollectionReference coache = FirebaseFirestore.instance.collection('Coach');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Coach Account"),),
      body:SafeArea(
          child: SingleChildScrollView(
              child :Padding (
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _fromKey,
                    child : Column (
                      //crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                      IconButton( icon:Icon(Icons.home , color:Theme.of(context).primaryColor) ,
                      onPressed: (){Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> MyApp())); },
                    ),
                    SizedBox(height : 10),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: TextFormField(
                        controller: _fname,
                        validator: (value){
                          if (value!.isEmpty){
                            return 'Your first name cannot be empty';
                          }
                          return null ;
                        },
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          hintText: 'Put your first name',
                          border : OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          prefixIcon: Icon(Icons.person),
                        ),),),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child :TextFormField(
                        controller: _lname,
                        validator: (value){
                          if (value!.isEmpty){
                            return 'Your last name cannot be empty';
                          }
                          return null ;
                        },
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          hintText: 'Put your last name',
                          border : OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: TextFormField(
                        controller: _phone,
                        validator: (value){
                          if (value!.isEmpty){
                            return 'Phone cannot be empty !';
                          }
                          if (value.length < 8){
                            return 'Phone cannot be less than 8 numbers !';
                          }else
                          if (value.length > 8){
                            return 'Phone cannot be upper than 8 numbers !';
                          }
                          return null ;
                        },
                        decoration: InputDecoration(
                          labelText: 'Phone',
                          hintText: 'Enter your phone number',
                          border : OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          prefixIcon: Icon(Icons.phone_android_sharp),
                        ),),),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child :TextFormField(
                        controller: _email,
                        validator: (value){
                          if (value!.isEmpty){
                            return 'User E-mail cannot be empty';
                          }
                          return null ;
                        },
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          hintText: 'Put your E-mail',
                          border : OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
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
                          hintText: 'Enter your password',
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
                         MaterialButton(onPressed : ()async {
                            if(_fromKey.currentState!.validate()){
                              coache
                                  .add({
                                'first_name': _fname.text,
                                'last_name': _lname.text,
                                'phone': _phone.text
                              })
                                  .then((value) => print("Coach Added"))
                                  .catchError((error) => print("Failed to add coach: $error"));
                         }},
                    height: 50,
                    minWidth: double.infinity,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white ,
                    shape :RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text("Submit" ,
                      style: TextStyle(fontSize: 15, fontWeight :FontWeight.bold),)),

                   SizedBox(height: 20),
                            ElevatedButton.icon(
                              label: Text('Exit'),
                              icon: Icon(Icons.exit_to_app),
                              style : ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.greenAccent),
                              ),
                              onPressed: () {
                                },
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment : MainAxisAlignment.center ,
                              children : [
                                Text("Already have an account ?"),
                                SizedBox(width: 20),
                                TextButton(onPressed: () {Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=> LogIn()));
                                },
                                  child: Text("Login"),
                                ),], ),],),),),),),);}}
    /// *******************************************************************

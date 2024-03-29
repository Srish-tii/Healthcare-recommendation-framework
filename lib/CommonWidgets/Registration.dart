import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'Login.dart';
import '../main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:toggle_switch/toggle_switch.dart';

class Registration extends StatelessWidget {
  final _fromKey = GlobalKey<FormState>();
  final _pwdController = TextEditingController();
  final _confpwdController = TextEditingController();
  final _fname = TextEditingController();
  final _lname = TextEditingController();
  final _email = TextEditingController();
  final _address = TextEditingController();
  final _phone = TextEditingController();

  @override
  // ignore: override_on_non_overriding_member
  final String user;
  Registration({required this.user});

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      style: TextButton.styleFrom(
          padding: const EdgeInsets.all(16.0),
          primary: Colors.white,
          textStyle: const TextStyle(fontSize: 20)),
      child: Text("OK"),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp()));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Exit"),
      content: Text("Do you want to exit?"),
      actions: [
        okButton,
      ],
      elevation: 24.0,
      backgroundColor: Colors.blueGrey[200],
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  CollectionReference coache = FirebaseFirestore.instance.collection('Coach');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("Create Coach Account"),
        title: Text("Create New Account"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _fromKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon:
                        Icon(Icons.home, color: Theme.of(context).primaryColor),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyApp()));
                    },
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                      controller: _fname,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Your first name cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        hintText: 'Put your first name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                      controller: _lname,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Your last name cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        hintText: 'Put your last name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  user == "doctor"
                      ? Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: TextFormField(
                            controller: _address,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Doctor Address cannot be empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Address',
                              hintText: 'Address',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              prefixIcon: Icon(Icons.home_work_outlined),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                      controller: _phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone cannot be empty !';
                        }
                        if (value.length < 8) {
                          return 'Phone cannot be less than 8 numbers !';
                        } else if (value.length > 8) {
                          return 'Phone cannot be upper than 8 numbers !';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        hintText: 'Enter your phone number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: Icon(Icons.phone_android_sharp),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                      controller: _email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'User E-mail cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        hintText: 'Put your E-mail name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                      obscureText: true,
                      controller: _pwdController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password cannot be empty !';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long !';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                      obscureText: true,
                      controller: _confpwdController,
                      validator: (value) {
                        if (value != _pwdController.value.text) {
                          return 'Passwords do not match !';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Confirm Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //!!!!!!!!!!!!!!!!!
                  // MaterialButton(
                  //     onPressed: () async {
                  //       if (_fromKey.currentState!.validate()) {
                  //         coache
                  //             .add({
                  //               'first_name': _fname.text,
                  //               'last_name': _lname.text,
                  //               'phone': _phone.text
                  //             })
                  //             .then((value) => print("Coach Added"))
                  //             .catchError((error) =>
                  //                 print("Failed to add coach: $error"));
                  //       }
                  //     },
                  //     height: 50,
                  //     minWidth: double.infinity,
                  //     color: Theme.of(context).primaryColor,
                  //     textColor: Colors.white,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     child: Text(
                  //       "Submit",
                  //       style: TextStyle(
                  //           fontSize: 15, fontWeight: FontWeight.bold),
                  //     )),
                  MaterialButton(
                      onPressed: () async {
                        if (_fromKey.currentState!.validate()) {
                          List<String> data = [];
                          String fname = _fname.text;
                          String lname = _lname.text;
                          String address = _address.text;
                          String phone = _phone.text;
                          String emails = _email.text;
                          String location = _determinePosition() as String;
                          data.add(fname);
                          data.add(lname);
                          data.add(phone);
                          data.add(address);
                          data.add(emails);
                          data.add(location);
                          http.Response res = user == "doctor"
                              ? await createDoctor(data)
                              : await createCoach(data);
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                                    email: emails,
                                    password: _pwdController.text);
                            print("created");
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              print(
                                  'The account already exists for that email.');
                            }
                          } catch (e) {
                            print(e);
                          }
                          if (res.statusCode == 200) {
                            AlertDialog show = AlertDialog(
                              title: Text("Congrats for joining us"),
                              content: Text(
                                  "Do you want to continue to your profile?"),
                              actions: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton(
                                      onPressed: () => {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return user == 'doctor'
                                              ? Login(user: 'doctor')
                                              : Login(user: 'coach');
                                        }))
                                      },
                                      child: Text("Ok"),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    TextButton(
                                      onPressed: () => {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MyApp())),
                                      },
                                      child: Text("exit"),
                                    ),
                                  ],
                                ),
                              ],
                              elevation: 24.0,
                              backgroundColor: Colors.blueGrey[200],
                            );
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => show);
                          }
                        }
                      },
                      height: 50,
                      minWidth: double.infinity,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    label: Text('Exit'),
                    icon: Icon(Icons.exit_to_app),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.greenAccent),
                    ),
                    onPressed: () {
                      showAlertDialog(context);
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account ?"),
                      SizedBox(width: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return user == 'doctor'
                                ? Login(user: 'doctor')
                                : Login(user: 'coach');
                          }));
                        },
                        child: Text("Login"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// --------------------- Coach location with permission  -----------------------
Future<Position> _determinePosition() async {
  return await Geolocator.getCurrentPosition();
}

// ----------------------------- Send Data to database --------------------------------------
Future<http.Response> createCoach(List<String> data) async {
  return http.post(
    Uri.parse(
        //'https://patient-tracking-34e27-default-rtdb.europe-west1.firebasedatabase.app/Coach.json'),
        'https://rastreador-6719e-default-rtdb.europe-west1.firebasedatabase.app/Coach.json'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "first name": data[0],
      "last name": data[1],
      "phone": data[2],
      "address": data[3],
      "email": data[4],
      "id_location": data[5],
      "id_patient": " ",
    }),
  );
}

Future<http.Response> createDoctor(List<String> data) {
  return http.post(
    Uri.parse(
        'https://rastreador-6719e-default-rtdb.europe-west1.firebasedatabase.app/caregiver.json'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "first name": data[0],
      "last name": data[1],
      "phone": data[2],
      "address": data[3],
      "email": data[4],
      "id_location": " ",
      "id_patient": " ",
    }),
  );
}

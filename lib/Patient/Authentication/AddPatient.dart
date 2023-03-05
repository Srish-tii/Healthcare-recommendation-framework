import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../CommonWidgets/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../main.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:http/http.dart' as http;

// DatabaseReference ref = FirebaseDatabase.instance.ref();
DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("patients");

class AddPatient extends StatefulWidget {
  @override
  RegisterPatient createState() {
    return RegisterPatient();
  }
}

class RegisterPatient extends State<AddPatient> {
  final _fromKey = GlobalKey<FormState>();
  final _pwdController = TextEditingController();
  final _confpwdController = TextEditingController();
  final _email = TextEditingController();
  final _firstname = TextEditingController();
  final _lastname = TextEditingController();
  final _phone = TextEditingController();
  final _age = TextEditingController();
  final _address = TextEditingController();
  String _gander = "";
  bool _success = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// register email and password patient
  void _register() async {
    print("In register");
    final User? user = (await _auth.createUserWithEmailAndPassword(
      email: _email.text,
      password: _pwdController.text,
    ))
        .user;
    if (user != null) {
      setState(() {
        _success = true;
      });
    }
  }

  showAlertDialog(BuildContext context) {
    /// set up the button
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
      content: Text("Do you want to exit !"),
      actions: [
        okButton,
      ],
      elevation: 24.0,
      backgroundColor: Colors.blueGrey[200],
    ); // show the dialog
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  // Create a CollectionReference called coaches that references the firestore collection
  CollectionReference patient =
      FirebaseFirestore.instance.collection('Patient');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Patient Account"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _fromKey,
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
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
                      controller: _firstname,
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
                      controller: _lastname,
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
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                      controller: _address,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'User Address cannot be empty';
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                      controller: _phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'User phone number cannot be empty';
                        } else if (value.length < 8) {
                          return 'Phone number must contains 8 Numbers !';
                        } else if (value.length > 8) {
                          return 'Phone number must contains only 8 Numbers !';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Phone ',
                        hintText: '+216  ',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: Icon(Icons.phone_android),
                      ),
                    ),
                  ),
                  // n// new Divider(height: 5.0, color: Colors.bl//------------- Select gender of user (radio) ---------------
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                      controller: _age,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Age cannot be empty';
                        } else if (value.length < 2) {
                          return 'Age must contains only 2 Numbers !';
                        } else if (value.length > 2) {
                          return 'Age must contains only 2 Numbers !';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Age ',
                        hintText: 'Age  ',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: Icon(Icons.account_circle),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      "Gender",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                          fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ToggleSwitch(
                      minWidth: 90.0,
                      initialLabelIndex: 1,
                      cornerRadius: 20.0,
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      totalSwitches: 2,
                      labels: ['Male', 'Female'],
                      icons: [Icons.male, Icons.female],
                      activeBgColors: [
                        [Colors.blue],
                        [Colors.pink]
                      ],
                      onToggle: (index) {
                        if (index == 0) {
                          _gander = "Female";
                        } else {
                          _gander = "Male";
                        }
                      },
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
                        hintText: 'Put your E-mail',
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
                          return 'password do not match !';
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
                  MaterialButton(
                      //
                      onPressed: () async {
                        if (_fromKey.currentState!.validate()) {
                          List<String> data = [];
                          //String firstname = _firstnameController.text;
                          String firstname = _firstname.text;
                          //String lastname = _lastnameController.text;
                          String lastname = _lastname.text;
                          //String age = _ageController.text;
                          String age = _age.text;
                          //String phone = _phoneController.text;
                          String phone = _phone.text;
                          //String address = _addressController.text;
                          String address = _address.text;
                          //String email = _emailController.text;
                          String email = _email.text;
                          //String pwd = _confpwdController.text;
                          String pwd = _pwdController.text;
                          data.add(firstname);
                          data.add(lastname);
                          data.add(age);
                          data.add(phone);
                          data.add(address);
                          data.add(_gander);
                          data.add(email);
                          data.add(pwd);
                          // dbRef.push().set(data);
                          http.Response res = await createPatient(data);
                          print(res.statusCode);
                          print("kshdbcj");
                          // if (res.statusCode == 201) {
                          print("Inside");
                          _register();
                          AlertDialog show = AlertDialog(
                            title: Text("Congrats for joining us"),
                            content: Text(
                                "Do you want to continue to your profile !"),
                            actions: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onPressed: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login(
                                                    user: '',
                                                  ))),
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
                                    child: Text("Cancel"),
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
                          // }
                        }
                      },

                      // onPressed: () async {
                      //   if (_fromKey.currentState!.validate()) {
                      //     patient
                      //         .add({
                      //           'first_name': _firstname.text,
                      //           'last_name': _lastname.text,
                      //           'address': _address.text,
                      //           'age': _age.text,
                      //           'gender': _gander.toString(),
                      //           'phone': _phone.text,
                      //           'email': _email.text,
                      //           'password': _pwdController.text,
                      //           'phone': _phone.text
                      //         })
                      //         .then((value) => print("patient created "))
                      //         .catchError((error) =>
                      //             print("Failed to add patient: $error"));
                      //   }
                      // },
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

                  SizedBox(height: 20),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Login(user: 'patient')));
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

  createPatient(List<String> data) {
    return dbRef.push().set(data);
  }
  // Future<http.Response> createPatient(List<String> data) {
  //   return http.post(
  //     Uri.parse(
  //         'https://rastreador-6719e-default-rtdb.europe-west1.firebasedatabase.app/'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{
  //       "first name": data[0],
  //       "last name": data[1],
  //       "age": data[2],
  //       "phone": data[3],
  //       "address": data[4],
  //       "email": data[5],
  //       "password": data[6],
  //       "gender": data[7],
  //       "id_disease": " ",
  //       "id_location": " ",
  //       "id_patient": " ",
  //     }),
  //   );
  // }
}

// Future<Position> _determinePosition() async {
//   return await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high);
//   // return await Geolocator.getCurrentPosition();
// }
// / --------------------- Sending Data To database -------------------
Future<http.Response> createPatient(List<String> data) {
  return http.post(
    Uri.parse(
        'https://patient-tracking-34e27-default-rtdb.europe-west1.firebasedatabase.app/patient.json'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "first name": data[0],
      "last name": data[1],
      "age": data[2],
      "phone": data[3],
      "address": data[4],
      "email": data[5],
      "password": data[6],
      "gender": data[7],
      "id_disease": " ",
      "id_location": " ",
      "id_patient": " ",
    }),
  );
}

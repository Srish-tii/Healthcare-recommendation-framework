import 'package:firebase_auth/firebase_auth.dart';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:rastreador/CommonWidgets/Registration.dart';
import 'package:rastreador/Patient/PatientHome/PatientHome.dart';
import 'package:rastreador/Doctor/DoctorHome/CaregiverHome.dart';
import 'package:rastreador/Coach/CoachHome.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../main.dart';
import '../Patient/Authentication/AddPatient.dart';
// import '../Doctor/Authentication/DoctorRegistration.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseDatabase database = FirebaseDatabase.instance;

//  --------------------------- Log in page ---------------------------------
class Login extends StatefulWidget {
  @override
  final String user;
  Login({required this.user});
  LoginUser createState() => LoginUser();
}

class LoginUser extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success = false;
  String _userEmail = "";
// -----------------------Test  firebase --------------------------------

  // ignore: non_constant_identifier_names
  UserNotExist() async {
    build(BuildContext context) {
      return AlertDialog(
        title: const Text(
            'packages/flutter_alert/assets/images/2.0x/icon_error.png'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[Text('This user dosn\'t exist')],
          ),
        ),
        actions: <Widget>[
          TextButton(
              child: const Text('Retry '),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
      );
    }
  }

  // ignore: non_constant_identifier_names
  UserExist() async {
    // ignore: unused_element
    build(BuildContext context) {
      return AlertDialog(
        title: const Text('Welcome !'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Do you want to continue to your profile? ')
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
              child: const Text('Yes '),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PatientProfile(),
                    ));
              }),
        ],
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon:
                        Icon(Icons.home, color: Theme.of(context).primaryColor),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyApp()));
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Welcome ",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Sign in to continue",
                    style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your Email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      hintText: 'E-mail',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
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
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: Icon(Icons.vpn_key),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  MaterialButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // try {
                          //   UserCredential userCredential = await FirebaseAuth
                          //       .instance
                          //       .signInWithEmailAndPassword(
                          //           email: _emailController.text,
                          //           password: _passwordController.text);
                          // } on FirebaseAuthException catch (e) {
                          //   if (e.code == 'user-not-found') {
                          //     print('No user found for that email.');
                          //   } else if (e.code == 'wrong-password') {
                          //     print('Wrong password provided for that user.');
                          //   }
                          // }
                          final User? user =
                              (await _auth.signInWithEmailAndPassword(
                            // (await _auth.createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ))
                                  .user;
                          if (user != null) {
                            setState(() {
                              _success = true;
                              _userEmail = user.email!;
                            });
                          } else {
                            setState(() {
                              _success = false;
                            });
                          }

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return widget.user == 'patient'
                                ? PatientProfile()
                                : widget.user == 'coach'
                                    ? Coachprofile()
                                    : Caregiverprofile();
                          }));
                        }
                      },
                      height: 50,
                      minWidth: double.infinity,
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "login",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      // ignore: unnecessary_null_comparison
                      _success == null
                          ? ''
                          : (_success
                              ? 'Successfully signed in ' + _userEmail
                              : 'Sign in failed'),
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account ?"),
                      SizedBox(width: 5),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return widget.user == 'patient'
                                ? AddPatient()
                                : widget.user == 'coach'
                                    ? Registration(user: "coach")
                                    : Registration(user: "doctor");
                          }));
                        },
                        child: Text("Register"),
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

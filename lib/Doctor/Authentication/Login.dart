import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rastreador/Coach/CoachRegistration.dart';
import 'package:rastreador/Doctor/CaregiverHome/CaregiverHome.dart';
import '../../main.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LogIn extends StatefulWidget {
  @override
  CaregiverLogin createState() => CaregiverLogin();
}

class CaregiverLogin extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success = true;
  String _userEmail = "";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('LogIn')),
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
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
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
                  ),
                  SizedBox(height: 30),
                  TextFormField(
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
                  SizedBox(height: 30),

                  /// ******************************** Test Caregiver data  ***********************************
                  MaterialButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final User? user =
                              (await _auth.createUserWithEmailAndPassword(
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
                              _success = true;
                            });
                          }
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Caregiverprofile()));
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
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account ?"),
                      SizedBox(width: 5),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationCoach()));
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
}

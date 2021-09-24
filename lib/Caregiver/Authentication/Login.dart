import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rastreador/Caregiver/Authentication/CoachRegistration.dart';
import 'package:http/http.dart' as http ;
import '../../main.dart';
/// ----------------------- Class Caregiver account  ----------------------
class Caregiver {
  final String email;
  final String password;
  Caregiver({
    required this.email,
    required this.password ,
  });
  factory Caregiver.fromJson(Map<String, dynamic> json) {
    return Caregiver(
      email: json['email'],
      password: json['password'],
    );
  }
}
Future<Caregiver> fetchCaregiver() async {
  final response = await http
      .get(Uri.parse('https://patient-tracking-34e27-default-rtdb.europe-west1.firebasedatabase.app/caregiver.json'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    return Caregiver.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load album');
  }
}
/// -------------------- caregiver login page using rest API ----------
class LogIn extends StatelessWidget {
  final  _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late Future<Caregiver> futureCaregiver;
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
                  IconButton(icon: Icon(Icons.home, color: Theme
                      .of(context)
                      .primaryColor), onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyApp()));
                  },),
                  SizedBox(height: 10),
                  Text("Welcome ", style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold),),
                  SizedBox(height: 10),
                  Text("Sign in to continue",
                    style: TextStyle(fontSize: 14, color: Colors.blueGrey),),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      hintText: 'E-mail',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      prefixIcon: Icon(Icons.email),
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
                  MaterialButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String email = _emailController.text;
                          String password = _passwordController.text;
                        }
                      },
                      height: 50,
                      minWidth: double.infinity,
                      color: Theme
                          .of(context)
                          .primaryColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text("login",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight
                            .bold),)),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account ?"),
                      SizedBox(width: 5),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationCoach()));
                        },
                        child: Text("Register"),
                      ),
                    ],),
                ],),
            ),
          ),),
      ),
    );
  }
}



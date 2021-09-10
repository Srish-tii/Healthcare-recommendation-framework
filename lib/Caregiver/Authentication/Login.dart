import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rastreador/Caregiver/Authentication/CoachRegistration.dart';

import '../../main.dart';

class

LogIn extends StatelessWidget {
  final  _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late bool _success;
// -----------------------Test  firebase --------------------------------
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
                  },
                  ),
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
                          print("Email :${_emailController.text}");
                          print("Password :${_passwordController.text}");
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
                            .bold),
                      )
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



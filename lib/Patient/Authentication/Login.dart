import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rastreador/Patient/Authentication/register.dart';
import 'package:rastreador/Patient/PatientHome/PatientHome.dart';
import '../../main.dart';
import 'package:http/http.dart' as http;
//  --------------------------- Log in page ---------------------------------
class Login extends StatelessWidget{
  final  _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late bool _success;
// -----------------------Test  firebase --------------------------------


/*  void _register() async {
final UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text);


    if (user != null) {
      _success = true;
      //_userEmail = user.Email;

    } else {
      {
        _success = true;
      }
    }
  }
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    //super.dispose();
  }*/
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> PatientProfile()));
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
                                    builder: (context) => Register()));
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

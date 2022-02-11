/// ************************** Old version of the patient registration page with realtime database *************************
import 'dart:convert' ;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart' ;
import 'package:flutter/material.dart' ;
import 'package:rastreador/Patient/Authentication/Login.dart' ;
import '../../main.dart' ;
import 'package:http/http.dart' as http ;
import 'package:geolocator/geolocator.dart';
import 'package:toggle_switch/toggle_switch.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
/// ---------------------- Subscription Page ----------------------------
class Register extends StatefulWidget {
  @override
  RegisterPatient createState (){return RegisterPatient();}
}
class RegisterPatient  extends State<Register> {
  final _fromKey = GlobalKey<FormState>();
  final _pwdController = TextEditingController();
  final _confpwdController = TextEditingController();
  final _emailController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _phoneController = TextEditingController() ;
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  String _gander = "" ;
  bool _success = false;
  /// register email and password patient
  void _register() async {
    final User? user = (await
    _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _pwdController.text,
    )).user;
    if (user != null) {
      setState(() {
        _success = true;
      });}
  }
  showAlertDialog(BuildContext context) {
    /// set up the button
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
      elevation: 24.0,
      backgroundColor: Colors.blueGrey[200],
    );// show the dialog
    showDialog(
        context: context,
        builder: (BuildContext context) => alert );
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
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child : TextFormField(
                      controller: _firstnameController,
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
                      ),),),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child :TextFormField(
                      controller: _lastnameController,
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
                      controller: _addressController,
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
                      controller : _phoneController ,
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
                        prefixIcon: Icon(Icons.phone_android),),),),
                  // n// new Divider(height: 5.0, color: Colors.bl//------------- Select gender of user (radio) ---------------
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child :TextFormField(
                      controller :_ageController,
                      validator: (value){
                        if (value!.isEmpty){
                          return 'Age cannot be empty';
                        }else if (value.length <2){
                          return 'Age must contains only 2 Numbers !';
                        }else if(value.length >2){
                          return 'Age must contains only 2 Numbers !';
                        }
                        return null ;
                      },
                      decoration: InputDecoration(
                        labelText: 'Age ',
                        hintText: 'Age  ',
                        border : OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: Icon(Icons.account_circle),),),),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text("Gender", style :TextStyle(fontWeight:FontWeight.bold,
                        color: Colors.blueGrey, fontSize: 15 ),),),
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
                      icons: [Icons.female, Icons.male],
                      activeBgColors: [[Colors.blue],[Colors.pink]],
                      onToggle: (index) {
                        if(index == 0)
                        { _gander = "Female";}
                        else { _gander = "Male";}
                      },),),

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
                      onPressed: () async{
                        if(_fromKey.currentState!.validate()){
                          List<String> data = [];
                          String firstname =_firstnameController.text ;
                          String lastname= _lastnameController.text ;
                          String age = _ageController.text ;
                          String  phone = _phoneController.text  ;
                          String address  = _addressController.text ;
                          String email = _emailController.text ;
                          String pwd = _confpwdController.text ;
                          data.add(firstname) ;
                          data.add(lastname);
                          data.add(age);
                          data.add (phone);
                          data.add(address);
                          data.add(_gander);
                          data.add(email);
                          data.add(pwd);
                          http.Response res = await createPatient(data) ;
                          if(res.statusCode == 200) {
                            _register();
                            _determinePosition() ;
                            AlertDialog show = AlertDialog(
                              title: Text("Congrats for joining us"),
                              content: Text("Do you want to continue to your profile !"),
                              actions: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton(
                                      onPressed:()=> {Navigator.push(context,
                                          MaterialPageRoute(builder: (context)=> Login())),
                                      }, child: Text("Ok"),
                                    ),
                                    SizedBox(width: 10,),
                                    TextButton(
                                      onPressed:() => {Navigator.push(context,
                                          MaterialPageRoute(builder: (context)=> MyApp())),},
                                      child: Text("Cancel"),),
                                  ],  ),  ] ,
                              elevation: 24.0,
                              backgroundColor: Colors.blueGrey[200],
                            );
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => show );
                          }}},
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
                      ),],),],),),),),),);
  }}
/// -------------------------- Patient location with permission -------------------------
Future<Position> _determinePosition() async {
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  // return await Geolocator.getCurrentPosition();
}
/// --------------------- Sending Data To database -------------------
Future<http.Response> createPatient(List<String> data) {
  return http.post(Uri.parse('https://patient-tracking-34e27-default-rtdb.europe-west1.firebasedatabase.app/patient.json'),
    headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8',},
    body: jsonEncode(<String, String>
    {
      "first name" : data[0],
      "last name" : data[1],
      "age" : data[2],
      "phone" : data[3],
      "address" : data[4],
      "email" : data[5],
      "password" :data[6],
      "gender" : data[7] ,
      "id_disease" : " ",
      "id_location" : " ",
      "id_patient" : " ",
    }),
  );
}

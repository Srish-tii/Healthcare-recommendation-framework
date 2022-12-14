import 'package:flutter/cupertino.dart';
import '../../CommonWidgets/Login.dart';
import 'AddPatient.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticatonState createState() => _AuthenticatonState();
}

class _AuthenticatonState extends State<Authentication> {
  bool isToggle = false;
  void toggleScreen() {
    setState(() {
      isToggle = !isToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isToggle) {
      return AddPatient();
    } else {
      return Login(user: "patient");
    }
  }
}

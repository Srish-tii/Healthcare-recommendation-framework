import '../Patient/Authentication/AddPatient.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'package:rastreador/CommonWidgets/Registration.dart';

class UserAccount extends StatelessWidget {
  final String user;
  final String text;
  UserAccount({required this.user, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return user == 'patient'
                    ? AddPatient()
                    : user == 'coach'
                        ? Registration(user: "coach")
                        : Registration(user: "doctor");
              }));
            },
            child: Text(text, style: TextStyle(color: Colors.white)),
          ),
          Text(' Or'),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Login(user: this.user);
              }));
            },
            child: Text("Login ", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

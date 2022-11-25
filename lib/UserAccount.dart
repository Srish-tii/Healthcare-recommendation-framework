import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class UserAccount extends StatelessWidget {
  final Widget NewUser;
  final Widget Login;
  UserAccount({required this.NewUser, required this.Login});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.push(
                  // ignore: unnecessary_statements
                  context, MaterialPageRoute(builder: (BuildContext context) {
                return NewUser;
              }));
            },
            child: Text("Create New Account",
                style: TextStyle(color: Colors.white)),
          ),
          Text(' Or'),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login));
            },
            child: Text("Login ", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

import 'Patient/Authentication/AddPatient.dart';
import 'package:flutter/material.dart';
import 'package:rastreador/Caregiver/Authentication/DoctorRegistration.dart';
import 'Coach/AddCoach.dart';

import 'package:rastreador/Caregiver/Authentication/Login.dart';
import 'Coach/Login.dart';
import 'Patient/Authentication/Login.dart';

class UserAccount extends StatelessWidget {
  // final Type NewUser;
  final String user;
  final String text;
  // final Type Login;
  // UserAccount({required this.NewUser, required this.Login});
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
                        ? AddCoach()
                        : RegistrationDoctor();
              }));
            },
            child: Text(text, style: TextStyle(color: Colors.white)),
          ),
          Text(' Or'),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return user == 'patient'
                    ? Login()
                    : user == 'coach'
                        ? CLogin()
                        : LogIn();
              }));
            },
            child: Text("Login ", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}


// import 'Patient/Authentication/AddPatient.dart';
// import 'package:flutter/material.dart';

// class UserAccount extends StatelessWidget {
//   final Type NewUser;
//   final Type Login;
//   UserAccount({required this.NewUser, required this.Login});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           TextButton(
//             onPressed: () {
//               Navigator.push(
//                   // ignore: unnecessary_statements
//                   context, MaterialPageRoute(builder: (BuildContext context) {
//                 return NewUser;
//               }));
//             },
//             child: Text("Create New Account",
//                 style: TextStyle(color: Colors.white)),
//           ),
//           Text(' Or'),
//           TextButton(
//             onPressed: () {
//               Navigator.push(
//                   context, MaterialPageRoute(builder: (context) => Login));
//             },
//             child: Text("Login ", style: TextStyle(color: Colors.white)),
//           ),
//         ],
//       ),
//     );
//   }
// }

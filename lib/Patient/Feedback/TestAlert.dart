import 'package:flutter/material.dart';
import 'package:rastreador/Patient/Feedback/Feedback.dart';
import '../PatientHome/PatientHome.dart';

class MyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        child: Text('Tap to start feedback quiz'),
        onPressed: () {
          showAlertDialog(context);
        },
      ),
    );
  }
}

// replace this function with the examples above
showAlertDialog(BuildContext context) {
  print('showAlertDialog called');
  // set up the buttons
  Widget startButton = TextButton(
    child: Text("Start"),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FeedbackPage()),
      );
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PatientProfile()),
      );
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("Give your feedback. Is this what you intended to do?"),
    actions: [
      startButton,
      cancelButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rastreador/Patient/Feedback/Quiz.dart';
import 'package:rastreador/Patient/PatientHome/PatientHome.dart';
import '../../main.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

DatabaseReference dbRef =
    FirebaseDatabase.instance.ref().child("patient_feedback");

/// ****** Intialization questions lists********
QuizBrain quizBrain = QuizBrain();

final FirebaseAuth _auth = FirebaseAuth.instance;
CollectionReference patient =
    FirebaseFirestore.instance.collection('PatientFeedback');

class FeedbackPage extends StatefulWidget {
  @override
  PatientFeedback createState() => PatientFeedback();
}

///  ------------------------ Feedback -------------------------

class PatientFeedback extends State<FeedbackPage> {
  List<Icon> scoreKeeper = [];
  final _formKey = GlobalKey<FormState>();
  final List<bool> _answers = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();
    setState(() {
      if (quizBrain.isFinished()) {
        // Reusable alert style
        var alertStyle = AlertStyle(
            animationType: AnimationType.fromTop,
            isCloseButton: false,
            isOverlayTapDismiss: false,
            descStyle: TextStyle(fontWeight: FontWeight.bold),
            animationDuration: Duration(milliseconds: 400),
            alertBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                color: Colors.grey,
              ),
            ),
            titleStyle: TextStyle(
              color: Colors.red,
            ),
            constraints: BoxConstraints.expand(width: 300),
            //First to chars "55" represents transparency of color
            overlayColor: Color(0x55000000),
            alertElevation: 0,
            alertAlignment: Alignment.topCenter);
        Alert(
          context: context,
          style: alertStyle,
          type: AlertType.info,
          title: "End Quiz",
          desc: "Save your feedback and return to your profile",
          buttons: [
            DialogButton(
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PatientProfile()),
                );
                Navigator.of(context, rootNavigator: true).pop();
              },
              color: Color.fromRGBO(0, 179, 134, 1.0),
              radius: BorderRadius.circular(0.0),
            ),
          ],
        ).show();
        //_updateFirebase(_answers);
        quizBrain.reset();
        scoreKeeper.clear();
        _answers.clear();
      } else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
          _answers.add(true);
          _updateFirebase(_answers);
          print(_answers);
        } else {
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
          _answers.add(false);
          _updateFirebase(_answers);
        }
        quizBrain.getNextQuestion();
      }
    });
  }

  // void _updateFirebase(List<bool> answers) async {
  //   try {
  //     final User? user = _auth.currentUser;
  //     await patient.doc(user!.uid).set({'answers': answers});
  //     print('Firebase updated with answers: $answers');
  //   } catch (e) {
  //     print('Error updating Firebase: $e');
  //   }
  // }
  void _updateFirebase(List<bool> answers) async {
    final User? user = _auth.currentUser;
    final patientId = user!.uid;

    final response = await http.patch(
      Uri.parse(
        'https://rastreador-6719e-default-rtdb.europe-west1.firebasedatabase.app/patient/$patientId.json',
      ),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'answers': answers,
      }),
    );

    if (response.statusCode == 200) {
      print('Firebase updated with answers: $answers');
    } else {
      print('Error updating Firebase: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            // ignore: deprecated_member_use
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                overlayColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () {
                checkAnswer(true);
              },
              child: Text(
                'Yes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              // textColor: Colors.white,
              // color: Colors.red,
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                overlayColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              onPressed: () {
                checkAnswer(false);
              },
              child: Text(
                'No',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
            ),
          ),
        ),
        Column(
          children: [
            Row(
              children: scoreKeeper,
            ),
            TextButton(
              onPressed: () {
                showAlertDialog(context);

                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => PatientProfile()));
              },
              child: Text('Finish'),
            )
          ],
        ),
      ],
    );
  }
}

showAlertDialog(BuildContext context) {
  print('showAlertDialog called');
  // set up the buttons
  Widget startButton = TextButton(
    child: Text("End"),
    onPressed: () {
      quizBrain.reset();

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PatientProfile()),
      );
      Navigator.of(context, rootNavigator: true).pop();
    },
  );
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text(
        "Are you sure you want to leave this page? Your progress will not be saved."),
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

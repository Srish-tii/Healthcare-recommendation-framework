import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rastreador/Patient/Feedback/Quiz.dart';
import 'package:rastreador/Patient/PatientHome/PatientHome.dart';
import '../../main.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

/// ***************** Intialization questions lists*********************
QuizBrain quizBrain = QuizBrain();

class FeedbackPage extends StatefulWidget {
  @override
  PatientFeedback createState() => PatientFeedback();
}

///  ------------------------ Feedback -------------------------
class PatientFeedback extends State<FeedbackPage> {
  List<Icon> scoreKeeper = [];
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
              onPressed: () => Navigator.pop(context, true),
              color: Color.fromRGBO(0, 179, 134, 1.0),
              radius: BorderRadius.circular(0.0),
            ),
          ],
        ).show();
        quizBrain.reset();
        scoreKeeper.clear();
      } else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        quizBrain.getNextQuestion();
      }
    });
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PatientProfile()));
              },
              child: Text('Finish'),
            )
          ],
        ),
      ],
    );
  }
}

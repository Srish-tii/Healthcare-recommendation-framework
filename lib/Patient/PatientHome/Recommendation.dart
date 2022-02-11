import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animator/animator.dart';
class Recommendation extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("recommendations"),),
      body: Animator<double>(
        tween: Tween<double>(begin:0,end:300),
        cycles:0,
        duration: Duration(seconds: 3),
        builder: (context, animatorState, child) => Center(child: Container(margin:EdgeInsets.symmetric(vertical:10),
            height: animatorState.value,
            width: animatorState.value,
            child: FlutterLogo()),),
      ),);
  }
}
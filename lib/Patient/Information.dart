import 'package:flutter/material.dart';

class MoreInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More about us'),
      ),
      body: Column(
        children: <Widget>[Text('Hello in more information page')],
      ),
    );
  }
}

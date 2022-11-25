import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class UserDescription extends StatelessWidget {
  final String imageString;
  final String content;

  UserDescription({required this.content, required this.imageString});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              content,
              softWrap: true,
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
              child:
                  Image(image: AssetImage(imageString), width: 120, height: 80),
            ),
          ),
        ],
      ),
    );
  }
}

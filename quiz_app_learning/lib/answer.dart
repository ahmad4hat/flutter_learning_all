import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function function;
  final String buttonText;
  final int questionIndex;
  final int answerIndex;

  Answer(this.function, this.buttonText, this.questionIndex, this.answerIndex);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: RaisedButton(
        color: Colors.green,
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () => function(questionIndex, answerIndex),
      ),
    );
  }
}

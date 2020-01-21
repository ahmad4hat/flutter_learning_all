import 'package:flutter/material.dart';
import './questions.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final int questionIndex;
  final Function addQuestion;
  final List<Map<String, dynamic>> listquestion;

  Quiz(@required this.addQuestion, @required this.listquestion,
      @required this.questionIndex);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Question(listquestion[questionIndex]['question']),
        SizedBox(
          height: 300.0,
          child: ListView.builder(
            itemCount: listquestion[questionIndex]['answers'].length,
            itemBuilder: (context, int index) {
              return Answer(
                  addQuestion,
                  listquestion[questionIndex]['answers'][index],
                  questionIndex,
                  index);
            },
          ),
        )
      ],
    );
  }
}

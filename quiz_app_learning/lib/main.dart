import 'dart:ffi';

import 'package:flutter/material.dart';

import './questions.dart';
import './answer.dart';
import './quiz.dart';
import './result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int questionIndex = 0;
  List<Map<String, dynamic>> listquestion = [
    {
      'question': 'what is your favourite programing lenguage ',
      'answers': ['dart', 'Js', 'Java', 'python', 'go']
    },
    {
      'question': 'why you love dart so much',
      'answers': ['i dont know', 'awesome', 'whats going on', 'i have no clue']
    },
    {
      'question': 'why you hat javascript so much',
      'answers': ['i dont know', 'awesome', 'whats going on', 'i have no clue']
    },
  ];

  Function addQuestion(int index, int answerIndex) {
    setState(() {
      questionIndex++;
      var key = choosenResult.keys.toList()[index];
      choosenResult[key] = listquestion[index]['answers'][answerIndex];
    });

    print(choosenResult);
  }

  Map<String, String> choosenResult = {
    'fovourite': null,
    'dart': null,
    'javascript': null
  };

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('quiz app begainig'),
      ),
      body: questionIndex < listquestion.length
          ? Quiz(addQuestion, listquestion, questionIndex)
          : Result(choosenResult),
    ));
  }
}

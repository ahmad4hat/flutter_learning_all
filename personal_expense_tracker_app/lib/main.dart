import 'package:flutter/material.dart';
import './screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'Nunito',
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(fontFamily: 'Nunito', fontSize: 25),
                button: TextStyle(color: Colors.white)),
          ),
          textTheme: TextTheme(button: TextStyle(color: Colors.white))),
      title: "Personal Expense trucker",
    );
  }
}

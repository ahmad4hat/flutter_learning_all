import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final Map results;
  Result(this.results);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Container(
        child: result(results),
      ),
    ));
  }

  Widget result(res) {
    print(res);
    List a = [];
    res.forEach((key, value) {
      a.add(Text(
        '$value',
        style: TextStyle(fontSize: 28, color: Colors.green),
      ));
    });

    return Column(
      children: <Widget>[...a],
    );
  }
}

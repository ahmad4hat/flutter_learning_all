import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final Map results;
  final Function reset;
  Result(this.results, this.reset);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(
        children: <Widget>[
          Container(
            child: result(results),
          ),
          RaisedButton(
            onPressed: reset,
            child: Text('reset'),
            color: Colors.red,
          )
        ],
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

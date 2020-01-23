import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  DateTime date;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "tilte"),
              controller: titleController,
              //onSubmitted: (_) => onSubmit(),
            ),
            TextField(
              decoration: InputDecoration(labelText: "amount"),
              keyboardType: TextInputType.number,
              controller: amountController,
              //onSubmitted: (_) => onSubmit(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(date == null
                        ? 'No Date Choosen'
                        : 'Picked Date ${DateFormat.yMMMd().format(this.date)}'),
                  ),
                  RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'add Date',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.button.color),
                    ),
                    onPressed: _datepicker,
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text(
                "Add transaction",
                style:
                    TextStyle(color: Theme.of(context).textTheme.button.color),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () => onSubmit(context),
            )
          ],
        ),
      ),
    );
  }

  void onSubmit(BuildContext context) {
    try {
      if (titleController.text == null ||
          amountController.text.isEmpty == null ||
          date == null) {
        throw Exception('my expection');
      }
      widget.addTransaction(
          titleController.text, double.parse(amountController.text), date);
    } catch (error) {
      print(error);
      return;
    }

    Navigator.of(context).pop();
  }

  void _datepicker() async {
    var date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now());

    if (date == null) {
      return;
    }
    setState(() {
      this.date = date;
    });

    return;
  }
}

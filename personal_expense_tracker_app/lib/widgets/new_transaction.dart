import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

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
            RaisedButton(
              child: Text("Add transaction"),
              color: Colors.pinkAccent,
              onPressed: () => onSubmit(context),
            )
          ],
        ),
      ),
    );
  }

  void onSubmit(BuildContext context) {
    try {
      widget.addTransaction(
          titleController.text, double.parse(amountController.text));
    } catch (error) {
      return;
    }

    Navigator.of(context).pop();
  }
}

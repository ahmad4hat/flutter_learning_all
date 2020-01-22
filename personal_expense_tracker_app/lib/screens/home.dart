import 'package:flutter/material.dart';
import './../models/transaction.dart';
import './../widgets/transaction_list.dart';
import './../widgets/new_transaction.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  final List<Transaction> transactions = [
    Transaction(id: 't1', title: 'food', amount: 69.9, date: DateTime.now()),
    Transaction(id: 't2', title: 'soda', amount: 64.9, date: DateTime.now()),
    Transaction(id: 't3', title: 'lpen', amount: 89.9, date: DateTime.now()),
  ];

  void addTransaction(String title, double amount) {
    setState(() {
      transactions.add(Transaction(
          id: DateTime.now().toString(),
          title: title,
          amount: amount,
          date: DateTime.now()));
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return GestureDetector(child: NewTransaction(addTransaction));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal expense trucker"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                child: Text(
                  'text',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            TransactionList(transactions)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          return startAddNewTransaction(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
